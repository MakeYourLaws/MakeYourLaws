class Fec::Filing
  FIRST_V3_FILING = 11850 # first filing number using the version >=3.00 format
  FILES_DIR = Rails.root.join('db', 'data', 'fec', 'filings')
  FECH_OPTIONS = {:translate => [:names, :dates], :download_dir => FILES_DIR} # :csv_parser => Fech::CsvDoctor, 
    
  # from=1; x=nil; Fech::Filing.for_all(Fec::Filing::FECH_OPTIONS.merge(:from=> from)) {|filing| x=filing; Fec::Filing.dostuff filing }
  
  def self.dostuff filing
    print "\n", filing.filing_id, ' '
    print filing.filing_version || filing.form_type, ' '
    if filing.filing_version.to_i >= 3
p      filing.header
p      filing.summary
      
      filing.amends
      filing.each_row_with_index do |row, i|
        mapped_row = filing.map row
print ' ', i, ' ',        Fech.base_type(mapped_row.row_type)
      end
      
    else
# print      filing.filing_version
    end
  end
  
  # Runs the passed block on every downloaded .fec file. Pass the same options hash as you would to Fech::Filing.new.
  # E.g. for_all(:download_dir => Rails.root.join('db', 'data', 'fec', 'filings', :csv_parser => Fech::CsvDoctor, ...) {|filing| ... }
  # filing.download is of course unnecessary.
  #
  # note that if there are a lot of files (e.g. after download_all), just listing them to prepare for this will take several seconds
  def self.for_all options = FECH_OPTIONS
    # .sort{|x| x.scan/\d+/.to_i } # should be no need to spend time on sort, since the file system should already do that
    Dir[File.join(FILES_DIR, '*.fec')].each do |file|
      filing = Fech::Filing.new(file.scan(/(\d+)\.fec/)[0][0].to_i, options)
      filing.translate do |t|
        t.convert :field => /(^|_)date/ do |value|
          Date.parse(value) rescue value
        end
      end
      yield filing
    end
  end

end