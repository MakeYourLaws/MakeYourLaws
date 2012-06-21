class Fec::Candidate < ActiveRecord::Base
  set_table_name "fec_candidates" # use namespaced table
  self.inheritance_column = :_type_disabled # disable STI
  
  # source: ftp://ftp.fec.gov/FEC/cn12.zip - updated weekly
                                                                          # length start end
  validates_uniqueness_of :fec_id                                         #  9   0    8
  # The candidate ID for a specific candidate remains the same across election cycles as long as the candidate is running for the same office.
  validates_length_of :fec_id, :is => 9
  validates_presence_of :fec_id #, :name  # S0ID00065 has null name
  validates_length_of :name, :maximum => 38                               # 39    9  46
  validates_length_of :party, :maximum => 3                               #  3   47  49
  # filler                                                                #  3   50  52
  validates_length_of :party_2, :maximum => 3                             #  3   53  55
    # Party 2 may have a value if no statement of candidacy was received. This information is taken from any other available source (e.g. state ballot lists, published information, etc.)
  validates_inclusion_of :incumbent_challenger, :in => %W(C I O),         #  1   56  56
    :allow_nil => true
      # C = Challenger I = Incumbent O = Open Seat is used to indicate an open seat. Open seats are defined as seats where the incumbent never sought re-election. There can be cases where an incumbent is defeated in the primary election. In these cases there will be two or more challengers in the general election.
  # filler                                                                #  1   57  57
  validates_inclusion_of :status, :in => %W(C F N P Q), :allow_nil => true  #  1   58  58
    # C = Statutory candidate
    # F = Statutory candidate for future election
    # N = Not yet a statutory candidate
    # P = Statutory candidate in prior cycle
  validates_length_of :street_1, :street_2, :maximum => 34                # 34   59  92 street 1
                                                                          # 34   93 126 street 2
  validates_length_of :city, :maximum => 18                               # 18  127 144
  validates_length_of :state, :maximum => 2                               #  2  145 146
  validates_length_of :zip, :maximum => 5                                 #  5  147 151
  validates_length_of :principal_campaign_committee, :is => 9,            #  9  152 160
   :allow_nil => true
    # The ID assigned by the Federal Election Commission to the candidate's principal campaign committee for a given election cycle
  validates_length_of :year, :maximum => 2                                #  2  161 162
    # Year of the election for which the candidate is running for office.
  validates_length_of :district, :maximum => 2                            #  2  163 164
    # District in which the candidate is running. For presidential and senate candidates this field will be missing or have a value of zero (00).
  
  attr_protected :id, :created_at, :fec_id
  before_validation do
    clean_attribs = (self.attributes.map do |k,v|
      if v.is_a?(String)
        new_v = v.strip.chars.select{|i| i.valid_encoding?}.join # drop invalid UTF-8 chars
        new_v = nil if new_v.blank? or %w(. NONE UNK 0).include?(new_v)
        [k, new_v] if v != new_v
      elsif k == 'district' and v.to_i == 0
        [k, nil]
      end
    end - [nil]).inject({}) {|h,(k,v)| h[k]=v; h} # an ugly version of to_hash
        
    self.attributes = clean_attribs # will only update the changed ones
p attributes
  end
  
  def self.new_from_line line, year = nil
    return nil if line.strip.blank?
    rec = self.find_or_initialize_by_fec_id line[0..8]
    rec.name                        = line[9..46]
    rec.party                       = line[47..49]
    raise 'Filler not blank' if year.to_i > 10 and !line[50..52].strip.blank?
    rec.party_2                     = line[53..55]
    rec.incumbent_challenger        = line[56..56]
    raise 'Filler not blank' if year.to_i > 10 and !line[57..57].strip.blank?
    rec.status                      = line[58..58]
    rec.street_1                    = line[59..92]
    rec.street_2                    = line[93..126]
    rec.city                        = line[127..144]
    rec.zip                         = line[147..151]
    rec.principal_campaign_committee= line[152..160]
    rec.year                        = line[161..162]
    rec.district                    = line[163..164]
    
    rec.last_update_year ||= year
    rec.last_update_year            = [year, rec.last_update_year].max rescue nil
    rec # not saved - meant for batch import
  end
  
  def self.update_from_line! line, year = nil
p line
    return nil if line.strip.blank?
    self.new_from_line(line, year).save!
  end
  
  def self.last_updated
    self.last(:order => :updated_at).updated_at rescue nil
  end
  
  def self.update!
    %w(80 82 84 86 88 90 92 94 96 98 00 02 04 06 08 10 12).each do |year|
      prev_mtime = Rails.root.join('db', 'data', "cn#{year}.zip").mtime rescue nil
      `cd #{Rails.root.join('db', 'data'} && wget -N ftp://ftp.fec.gov/FEC#{"/19#{year}" if year.to_i >= 80}/cn#{year}.zip`
      mtime = Rails.root.join('db', 'data', "cn#{year}.zip").mtime # -N preserves the ftp server's date
      next unless !prev_mtime or !last_updated or last_updated < mtime or prev_mtime < mtime
    
      filename = Rails.root.join('db', 'data', "fec_candidates_#{year}_#{mtime.to_date}.dta")
      `cd #{Rails.root.join('db', 'data'} && unzip -u -j -o #{Rails.root.join 'db', 'data', "cn#{year}.zip"}`
      dataname = case year.to_i
        when 80..87 then "FOIACN.D#{year}"
        when 88..97 then "FOIACN.DTA"
        else 'foiacn.dta'
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