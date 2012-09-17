# Direct representation of authoritative New York statewide voter registration database records.
class Voter::Ny < ActiveRecord::Base
  self.table_name = "ny_voters" # use namespaced table
  QUOTE_CHAR = '"'; REPLACEMENT_CHAR = "'"; ROW_SEP = "\r\n"; COL_SEP = ","
  
  NY_COUNTIES = ["Albany", "Allegany", "Bronx", "Broome", "Cattaraugus", "Cayuga", "Chautauqua", "Chemung", "Chenango", "Clinton", "Columbia", "Cortland", "Delaware", "Dutchess", "Erie", "Essex", "Franklin", "Fulton", "Genesee", "Greene", "Hamilton", "Herkimer", "Jefferson", "Kings", "Lewis", "Livingston", "Madison", "Monroe", "Montgomery", "Nassau", "New York", "Niagara", "Oneida", "Onondaga", "Ontario", "Orange", "Orleans", "Oswego", "Otsego", "Putnam", "Queens", "Rensselaer", "Richmond", "Rockland", "Saratoga", "Schenectady", "Schoharie", "Schuyler", "Seneca", "St. Lawrence", "Steuben", "Suffolk", "Sullivan", "Tioga", "Tompkins", "Ulster", "Warren", "Washington", "Wayne", "Westchester", "Wyoming", "Yates"]
  
  def self.county_name county_code
    NY_COUNTIES[county_code + 1]
  end
  
  def self.import_file filename
    file = File.open filename, :encoding => 'UTF-8'
    batch = []
    columns = self.column_names[1..-4] # id ... lock, created, updated
    
    # memoize for speed
    beginquote_regex = /\A\s*#{QUOTE_CHAR}/
    endquote_regex = /#{QUOTE_CHAR}\s*#{ROW_SEP}\Z/
    quote_sep_quote_regex2 = /#{QUOTE_CHAR}\s*(#{COL_SEP})\s*#{QUOTE_CHAR}/
    
    quote_sep_quote_regex = /#{QUOTE_CHAR}\s*#{COL_SEP}\s*#{QUOTE_CHAR}/
    quote_sep_regex = /#{QUOTE_CHAR}\s*#{COL_SEP}\s*[0-9]/
    sep_quote_regex = /[0-9]\s*#{COL_SEP}\s*#{QUOTE_CHAR}/
    unquoted_sep_regex = /[\x1E|\A][^\x03\x1E\x02#{COL_SEP}]*#{COL_SEP}/
    
    # example of a horribly malformed line:
    # "1","2,3","foo","bar "qux"    # yes, this is a newline within a quoted field
    #   baz",5,njn,a "b" c,yu,98    
    
    
    while line = file.gets
      # String#encode requires ruby 1.9. Just one :invalid => replace doesn't work; e.g. try: "107\xAB FOOBAR RD" (note invalid \xAB)
      # Yes, it's a kludge and it's expensive, but it works. Replace with something better.
      line = line.encode('UTF-16', 'UTF-8', :invalid => :replace, :replace => '').encode('UTF-8', 'UTF-16') 
      # Replace properly formed quote-separator-quote sequences with ASCII RS (record separator \1E)
      # Mark text with ASCII STX (start text \02) - ETX not required, since STXRS is unambiguous
      # Then replace all other (internal) quotes with '
      # Then replace all separators not within text area with RS
      line = line.gsub(beginquote_regex, "\x02").gsub(endquote_regex, "\x03").gsub(quote_sep_quote_regex, "\x03\x1E\x03").gsub(quote_sep_regex, "\x03\x1E").gsub(sep_quote_regex, "\x1E\x03").gsub(QUOTE_CHAR, REPLACEMENT_CHAR).gsub(unquoted_sep_regex, "\x1E")
      
      batch << CSV.parse_line(line, :col_sep => "\x1E", :quote_char => "\x03")
      if batch.size > 1000
        self.import columns, batch, :on_duplicate_key_update => (columns - ['voter_id'])
        batch = []
      end
    end
    self.import columns, batch, :on_duplicate_key_update => (columns - ['voter_id'])
    batch = []
    file.close
    
  end
  
  # must pass opened File object, takes block to apply to a line
  def self.parsefile file
    while line = file.gets
      fields = [ ]
      unless line == "\n"
        loop do
          while line.sub!(/\A("(?:""|[^"]*)+"|(?!")[^,]*)(?:,|\n)/, "")
            if $1.empty?
              fields << nil
            elsif $1.start_with? '"'
              fields << $1[1..-2].gsub('""', '"')
            else
              fields << $1
            end
          end
          break if     line.empty?
          break unless more = file.gets
          line += more
        end
      end
      yield fields
    end
  end
  
end