class Fec::Committee < ActiveRecord::Base
  self.table_name = 'fec_committees' # use namespaced table
  self.inheritance_column = :_type_disabled # disable STI
  FILES_DIR = Rails.root.join('db', 'data', 'fec', 'committee_master_files')

  has_paper_trail
  # attr_protected :id, :created_at, :fec_id

  # source: ftp://ftp.fec.gov/FEC/cm12.zip - updated weekly
  #                                                                      length start end
  validates :fec_id, unique: true, length: { is: 9 }, presence: true    #  9    0   8
  validates :name, presence: true, length: { maximum: 90 }              # 90    9  98
  validates :treasurer_name, length: { maximum: 38 }                    # 38   99 136
  validates :street_1, :street_2, length: { maximum: 34 }               # 34  137 170 street 1
  #                                                                       34  171 204 street 2
  validates :city, length: { maximum: 18 }                              # 18  205 222
  validates :state, length: { maximum: 2 }                              #  2  223 224
  validates :zip, length: { maximum: 5 }                                #  5  225 229
  validates :designation, allow_nil: true,                              #  1  230 230
                          inclusion: { in: Fec::CommitteeDesignation::TYPES.keys }
  validates :type, inclusion: { in: Fec::CommitteeType::TYPES.keys }    #  1  231 231
  validates :party, length: { maximum: 3 }                              #  3  232 234
  validates :filing_frequency, allow_nil: true,                         #  1  235 235
                               inclusion: { in: Fec::CommitteeFilingFrequency::TYPES.keys }
  validates :interest_group_category,                                   #  1  236 236
    allow_nil: true, inclusion: { in: Fec::CommitteeInterestGroupCategory::TYPES.keys }
  validates :connected_organization_name, length: { maximum: 38 }       # 38  237 274

  # if committee type H S or P
  validates :candidate_id, length: { is: 9 }, allow_nil: true           #  9  275 283

  # not very reliable, since the name is often partial
  belongs_to :connected_organization, foreign_key: 'connected_organization_name',
    primary_key: 'name', class_name: 'Fec::Committee'

  belongs_to :candidate, primary_key: 'fec_id', class_name: 'Fec::Candidate'

  before_validation do
    attribs = attributes.map do |k, v|
      if v.is_a?(String)
        new_v = v.strip.chars.select { |i| i.valid_encoding? }.join # drop invalid UTF-8 chars
        new_v = nil if new_v.blank? || %w(. NONE UNK 0).include?(new_v)
        [k, new_v] if v != new_v
      end
    end
    attribs -= [nil]
    # will only update the changed ones
    self.attributes = attribs.reduce({}) { |h, (k, v)| h[k] = v; h } # an ugly version of to_hash
  end

  def self.new_from_line line, year = nil
    rec = find_or_initialize_by_fec_id line[0..8]
    rec.name                        = line[9..98]
    rec.treasurer_name              = line[99..136]
    rec.street_1                    = line[137..170]
    rec.street_2                    = line[171..204]
    rec.city                        = line[205..222]
    rec.state                       = line[223..224]
    rec.zip                         = line[225..229]
    rec.designation                 = line[230]
    rec.type                        = line[231]
    rec.party                       = line[232..234]
    rec.filing_frequency            = line[235]
    rec.interest_group_category     = line[236]
    rec.connected_organization_name = line[237..274]
    rec.candidate_id                = line[275..283]

    rec.last_update_year ||= year
    rec.last_update_year            = [year, rec.last_update_year].max rescue nil
    rec # not saved - meant for batch import
  end

  def self.update_from_line! line, year = nil
    new_from_line(line, year).save!
  end

  def self.last_updated
    last(order: :updated_at).updated_at rescue nil
  end

  def self.update!
    # New years' "master" files may or may not include previous years' orgs. Bah.
    %w(80 82 84 86 88 90 92 94 96 98 00 02 04 06 08 10 12).each do |year|
      prev_mtime = File.mtime(File.join(FILES_DIR, "cm#{year}.zip")) rescue nil
      # wget -N preserves the ftp server's date
      `cd #{FILES_DIR} && wget -N ftp://ftp.fec.gov/FEC#{year.to_i >= 80 ?
        "/19#{year}" : ''}/cm#{year}.zip`
      mtime = File.mtime(File.join(FILES_DIR, "cm#{year}.zip"))
      next unless !prev_mtime || !last_updated || last_updated < mtime || prev_mtime < mtime

      filename = File.join(FILES_DIR, "fec_commitees_#{year}_#{mtime.to_date}.dta")
      `cd #{FILES_DIR} && unzip -u -j -o #{File.join(FILES_DIR, "cm#{year}.zip")}`
      dataname = case year.to_i
                   when 80..87 then "FOIACM.D#{year}"
                   when 88..97 then 'FOIACM.DTA'
                   else 'foiacm.dta'
                 end
      File.rename File.join(FILES_DIR, dataname), filename

      begin
        file = File.open(filename, 'r')
        # batch = []
        while line = file.gets
          self.update_from_line! line, (year.to_i >= 80 ? 1900 + year.to_i : 2000 + year.to_i)
          # batch << self.new_from_line(line)
          # if batch.size > 1000
          #   self.import batch, :on_duplicate_key_update => (self.column_names -
          #      %w(id fec_id created_at)).map(&:to_sym)
          #   batch = []
          # end
        end
        # self.import batch, :on_duplicate_key_update => (self.column_names -
        #    %w(id fec_id created_at)).map(&:to_sym)
        # batch = []

        true
      ensure
        file.close if defined?(file) && file
      end
    end
  end
end
