class Fec::Candidate < ActiveRecord::Base
  self.table_name = 'fec_candidates' # use namespaced table
  self.inheritance_column = :_type_disabled # disable STI
  FILES_DIR = Rails.root.join('db', 'data', 'fec', 'candidate_master_files')

  has_paper_trail

  # attr_protected :id, :created_at, :fec_id

  # source: ftp://ftp.fec.gov/FEC/cn12.zip - updated weekly
  #                                                                     length start end
  validates :fec_id, uniqueness: true, length: { is: 9 }, presence: true #  9    0   8
  # The candidate ID for a specific candidate remains the same across election cycles as long as
  #  the candidate is running for the same office.

  # S0ID00065 has null name
  validates :name, length: { maximum: 38 }                              # 39    9  46
  validates :party, length: { maximum: 3 }                              #  3   47  49
  # filler                                                              #  3   50  52
  validates :party_2, length: { maximum: 3 }                            #  3   53  55
  # Party 2 may have a value if no statement of candidacy was received. This information is taken
  #  from any other available source (e.g. state ballot lists, published information, etc.)

  validates :incumbent_challenger, allow_nil: true,                     #  1   56  56
                                   inclusion: { in: Fec::CandidateIncumbent::TYPES.keys }
  # C = Challenger
  # I = Incumbent
  # O = Open Seat
  # Open seats are defined as seats where the incumbent never sought re-election. There can be
  #  cases where an incumbent is defeated in the primary election. In these cases there will be two
  #  or more challengers in the general election.

  # filler                                                              #  1   57  57
  validates :status, allow_nil: true,                                   #  1   58  58
                     inclusion: { in: Fec::CandidateStatus::TYPES.keys }
  validates :street_1, :street_2, length: { maximum: 34 }               # 34   59  92 street 1
  #                                                                     # 34   93 126 street 2
  validates :city, length: { maximum: 18 }                              # 18  127 144
  validates :state, length: { maximum: 2 }                              #  2  145 146
  validates :zip, length: { maximum: 5 }                                #  5  147 151
  validates :principal_campaign_committee, length:    { is: 9 },        #  9  152 160
                                           allow_nil: true
  # The ID assigned by the Federal Election Commission to the candidate's principal campaign
  #  committee for a given election cycle

  validates :year, length: { maximum: 2 }                               #  2  161 162
  # Year of the election for which the candidate is running for office.
  validates :district, length: { maximum: 2 }                           #  2  163 164
  # District in which the candidate is running. For presidential and senate candidates this field
  #  will be missing or have a value of zero (00).

  belongs_to :committee, foreign_key: 'principal_campaign_committee', primary_key: 'fec_id',
    class_name: 'Fec::Committee'

  before_validation do
    attribs = attributes.map do |k, v|
      if v.is_a?(String)
        new_v = v.strip.chars.select { |i| i.valid_encoding? }.join # drop invalid UTF-8 chars
        new_v = nil if new_v.blank? || %w(. NONE UNK 0).include?(new_v)
        [k, new_v] if v != new_v
      elsif k == 'district' && v.to_i == 0
        [k, nil]
      end
    end
    attribs -= [nil]
    # will only update the changed ones
    self.attributes = attribs.reduce({}) { |h, (k, v)| h[k] = v; h } # an ugly version of to_hash
  end

  def self.new_from_line line, year = nil
    return nil if line.strip.blank?
    rec = find_or_initialize_by_fec_id line[0..8]
    rec.name                         = line[9..46]
    rec.party                        = line[47..49]
    # raise 'Filler not blank' if year.to_i > 10 and !line[50..52].strip.blank?
    rec.party_2                      = line[53..55]
    rec.incumbent_challenger         = line[56..56]
    # raise 'Filler not blank' if year.to_i > 10 and !line[57..57].strip.blank?
    rec.status                       = line[58..58]
    rec.street_1                     = line[59..92]
    rec.street_2                     = line[93..126]
    rec.city                         = line[127..144]
    rec.zip                          = line[147..151]
    rec.principal_campaign_committee = line[152..160]
    rec.year                         = line[161..162]
    rec.district                     = line[163..164]

    rec.last_update_year ||= year
    rec.last_update_year             = [year, rec.last_update_year].max rescue nil
    rec # not saved - meant for batch import
  end

  def self.update_from_line! line, year = nil
    # p line
    return nil if line.strip.blank?
    new_from_line(line, year).save!
  end

  def self.last_updated
    last(order: :updated_at).updated_at rescue nil
  end

  def self.update!
    %w(80 82 84 86 88 90 92 94 96 98 00 02 04 06 08 10 12).each do |year|
      prev_mtime = File.mtime(File.join(FILES_DIR, "cn#{year}.zip")) rescue nil
      # wget -N preserves the ftp server's date
      `cd #{FILES_DIR} && wget -N ftp://ftp.fec.gov/FEC#{year.to_i >= 80 ?
        "/19#{year}" : ''}/cn#{year}.zip`
      mtime = File.mtime(File.join(FILES_DIR, "cn#{year}.zip"))
      next unless !prev_mtime || !last_updated || last_updated < mtime || prev_mtime < mtime

      filename = File.join(FILES_DIR, "fec_candidates_#{year}_#{mtime.to_date}.dta")
      `cd #{FILES_DIR} && unzip -u -j -o #{File.join(FILES_DIR, "cn#{year}.zip")}`
      dataname = case year.to_i
                   when 80..87 then "FOIACN.D#{year}"
                   when 88..97 then 'FOIACN.DTA'
                   else 'foiacn.dta'
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
          #     %w(id fec_id created_at)).map(&:to_sym)
          #   batch = []
          # end
        end
        # self.import batch, :on_duplicate_key_update => (self.column_names -
        #   %w(id fec_id created_at)).map(&:to_sym)
        # batch = []

        true
      ensure
        file.close if defined?(file) && file
      end
    end
  end
end
