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
      :birth_date_badleap => (sanitize_date(line[73..80])[1] == :badleap)
  end
  
  
  def self.sanitize_date date
    return [nil, nil] if date.to_i == 0 or date.blank? or date.to_i == 1900

    # some dates have DD '00', so treat that as DD 01 and set a flag instead
    [Date.new(date[4..7].to_i, date[0..1].to_i, date[2..3].to_i), nil]
  rescue ArgumentError
    if date[2..3].to_i > 28
      [Date.new(date[4..7].to_i, date[0..1].to_i + 1, 1), :badleap]
    elsif (date[2..3].to_i == 0) and (date[0..1].to_i == 0)
      [nil, :nodate]
    elsif date[2..3].to_i == 0
      [Date.new(date[4..7].to_i, date[0..1].to_i, 1), :nodate]
    elsif date[0..1].to_i == 0
      [Date.new(date[4..7].to_i, 1, date[2..3].to_i), :nodate]
    else
      raise ArgumentError
    end
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
    self.import batch 
    batch = []
    file.close
  end
end