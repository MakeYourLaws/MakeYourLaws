class Govt::SsnDeathRecord < ActiveRecord::Base
  def self.new_from_line line
    self.new :change_type => (line[0].blank? ? nil : line[0]),
      :ssn => line[1..9].to_i,
      :last_name => (line[10..29].blank? ? nil : line[10..29].strip),
      :name_suffix => (line[30..33].blank? ? nil : line[30..33].strip),
      :first_name => (line[34..48].blank? ? nil : line[34..48].strip),
      :middle_name => (line[49..63].blank? ? nil : line[49..63].strip),
      :verified => case line[64]
          when ' ' then nil
          when 'V' then true
          when 'P' then false
          else raise "Unknown verification code"
        end,
      :death_date => sanitize_date(line[65..72])[0],
      :death_date_noday => (sanitize_date(line[65..72])[1] == :nodate),
      :death_date_badleap => (sanitize_date(line[65..72])[1] == :badleap),
      :birth_date => sanitize_date(line[73..80])[0],
      :birth_date_noday => (sanitize_date(line[73..80])[1] == :nodate),
      :birth_date_badleap => (sanitize_date(line[73..80])[1] == :badleap),
      :age_in_days => ((sanitize_date(line[65..72])[0] - sanitize_date(line[73..80])[0]).to_i rescue nil)
  end
  
  
  def self.sanitize_date date
    return [nil, nil] if date.to_i == 0 or date.blank? or date.to_i == 1900

    # Format: MMDDYYYY
    error, month, day, year = nil, date[0..1].to_i, date[2..3].to_i, date[4..7].to_i
    if day > 28 and month == 2
      day = 28 # meh leap years
      error = :badleap
    elsif year < 1800
      return [nil, :nodate]
    elsif (day == 0) and (month == 0)
      return [nil, :nodate]
    # some dates have DD '00', so treat that as DD 01 and set a flag instead
    elsif day == 0
      day = 1
    elsif month == 0
      month = 1
    end
    
    date = Date.new(year, month, day) rescue nil
    [date, error]
  end
  
  def self.import_from_file filename
    file = File.open(filename, 'r')
    batch = []
    while line = file.gets
      raise 'Unknown data' unless line[81..-1].blank?
      batch << self.new_from_line(line)
      if batch.size > 1000
        self.import batch 
        batch = []
      end
    end
    self.import batch, :on_duplicate_key_update => []  # ignore duplicates
    batch = []
    file.close
  end
end