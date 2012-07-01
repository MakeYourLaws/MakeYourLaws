class Fec::Committee < ActiveRecord::Base
  self.table_name = "fec_committees" # use namespaced table
  self.inheritance_column = :_type_disabled # disable STI
  
  has_paper_trail
  
  # source: ftp://ftp.fec.gov/FEC/cm12.zip - updated weekly
                                                                          # length start end
  validates_uniqueness_of :fec_id                                         #  9   0    8
  validates_length_of :fec_id, :is => 9
  validates_presence_of :fec_id, :name     
  validates_length_of :name, :maximum => 90                               # 90   9   98
  validates_length_of :treasurer_name, :maximum => 38                     # 38  99  136
  validates_length_of :street_1, :street_2, :maximum => 34                # 34  137 170 street 1
                                                                          # 34  171 204 street 2
  validates_length_of :city, :maximum => 18                               # 18  205 222
  validates_length_of :state, :maximum => 2                               #  2  223 224
  validates_length_of :zip, :maximum => 5                                 #  5  225 229
  validates_inclusion_of :designation, :in => Fec::CommitteeDesignation::TYPES.keys,  #  1  230 230
   :allow_nil => true
  validates_inclusion_of :type, :in => Fec::CommitteeType::TYPES.keys     #  1  231 231
  validates_length_of :party, :maximum => 3                               #  3  232 234
  validates_inclusion_of :filing_frequency, :in => Fec::CommitteeFilingFrequency::TYPES.keys, #  1  235 235
    :allow_nil => true
  validates_inclusion_of :interest_group_category, :in => Fec::CommitteeInterestGroupCategory::TYPES.keys, #  1  236 236
    :allow_nil => true
  validates_length_of :connected_organization_name, :maximum => 38        # 38  237 274
  validates_length_of :candidate_id, :is => 9, :allow_nil => true         #  9  275 283 (if committee type H S or P)
  
  attr_protected :id, :created_at, :fec_id
  before_validation do
    clean_attribs = (self.attributes.map do |k,v| 
      if v.is_a?(String)
        new_v = v.strip.chars.select{|i| i.valid_encoding?}.join # drop invalid UTF-8 chars
        new_v = nil if new_v.blank? or %w(. NONE UNK 0).include?(new_v)
        [k, new_v] if v != new_v
      end
    end - [nil]).inject({}) {|h,(k,v)| h[k]=v; h} # an ugly version of to_hash
    
    self.attributes = clean_attribs # will only update the changed ones
  end
  
  def self.new_from_line line, year = nil
    rec = self.find_or_initialize_by_fec_id line[0..8]
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
    self.new_from_line(line, year).save!
  end
  
  def self.last_updated
    self.last(:order => :updated_at).updated_at rescue nil
  end
  
  def self.update!
    # New years' "master" files may or may not include previous years' orgs. Bah.
    %w(80 82 84 86 88 90 92 94 96 98 00 02 04 06 08 10 12).each do |year|
      prev_mtime = Rails.root.join('db', 'data', "cm#{year}.zip").mtime rescue nil
      `cd #{Rails.root.join('db', 'data')} && wget -N ftp://ftp.fec.gov/FEC#{"/19#{year}" if year.to_i >= 80}/cm#{year}.zip`
      mtime = Rails.root.join('db', 'data', "cm#{year}.zip").mtime # -N preserves the ftp server's date
      next unless !prev_mtime or !last_updated or last_updated < mtime or prev_mtime < mtime
    
      filename = Rails.root.join('db', 'data', "fec_commitees_#{year}_#{mtime.to_date}.dta")
      `cd #{Rails.root.join('db', 'data')} && unzip -u -j -o #{Rails.root.join 'db', 'data', "cm#{year}.zip"}`
      dataname = case year.to_i
        when 80..87 then "FOIACM.D#{year}"
        when 88..97 then "FOIACM.DTA"
        else 'foiacm.dta'
      end
      File.rename Rails.root.join('db', 'data', dataname), filename
    
      begin
        file = File.open(filename, 'r')
        # batch = []
        while line = file.gets
          self.update_from_line! line, (year.to_i >= 80 ? 1900 + year.to_i : 2000 + year.to_i)
          # batch << self.new_from_line(line)
          # if batch.size > 1000
          #   self.import batch, :on_duplicate_key_update => (self.column_names - %w(id fec_id created_at)).map(&:to_sym)
          #   batch = []
          # end
        end
        # self.import batch, :on_duplicate_key_update => (self.column_names - %w(id fec_id created_at)).map(&:to_sym)
        # batch = []
    
        true
      ensure
        file.close if defined?(file) and file
      end
    end
  end
end