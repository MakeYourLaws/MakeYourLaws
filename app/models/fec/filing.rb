class Fec::Filing
  FIRST_V3_FILING = 11_850 # first filing number using the version >=3.00 format
  FILES_DIR = Rails.root.join('db', 'data', 'fec', 'filings')
  FECH_OPTIONS = { translate: [:names, :dates], download_dir: FILES_DIR, csv_parser: Fech::CsvDoctor}

  def self.base_type row_type
    FechUtils::ROW_TYPES.sort{|x,y| y[1].to_s.length <=> x[1].to_s.length }.find{|k,v| k if row_type =~ v }.first
  end

  # from=1; x=nil;
  # Fech::Filing.for_all(Fec::Filing::FECH_OPTIONS.merge(:from=> from)) {|filing|
  #   x=filing; Fec::Filing.dostuff filing }
  def self.update_database
    # record_number = Fec::Filing::Hdr.maximum(:fec_record_number) || Fec::Filing::FIRST_V3_FILING
    record_number = Fec::Filing::FIRST_V3_FILING
    record_number -= 1
    threads = []
    while(true) do
      # FIXME: add break condition when reaching last record
      threads.delete_if{|t| !t.alive?}
      if threads.select{|t| t.alive?}.count < 2
        record_number += 1
        threads << Thread.new do
          ActiveRecord::Base.establish_connection
          begin
            print ' ' + record_number.to_s
            Fec::Filing::download_and_save record_number
          rescue => e
            File.write(File.join(Rails.root, 'db', 'data', 'fec', 'filings', 'errors', "#{record_number}"), e.inspect.to_s + "\n\n" + e.awesome_backtrace.to_s)
            file_path = File.join(Rails.root, 'db', 'data', 'fec', 'filings', "#{record_number}.fec")
            File.delete(file_path) if File.exists? file_path
          end
        end
      end
    end
  end

  # 12104 row 536; 12164 5; 12298 17; 12302 17: row[:form_type] = row.delete(:ballot_local_candidates)
    #
  # filing = Fech::Filing.new(record_number, Fec::Filing::FECH_OPTIONS)
  # filing.download
  # rows = filing.rows_like(//); i = 0
  # row = rows[i]; t = Fec::Filing.base_type (row[:rec_type] || row[:record_type] || row[:form_type] || row.delete(:ballot_local_candidates)); klass = "Fec::Filing::#{t[0].upcase}#{t[1..-1]}".constantize; rec = klass.find_or_initialize_by(fec_record_number: record_number, row_number: i); row.delete(nil); rec.assign_attributes row; rec.save && i += 1


  def self.download_and_save record_number
    filing = Fech::Filing.new(record_number, FECH_OPTIONS)
    filing.download

    if filing.filing_version.to_i >= 3
      # batch = {}
      filing.rows_like(//).each_with_index do |row, i|
        begin
          print ' ' + i.to_s
          # mapped_row = filing.map row
          t = self.base_type (row[:record_type] || row[:form_type]) ||
           row.delete(:ballot_local_candidates) # Some records are malformed,
                                                # eg 12104 row 536; 12164 5; 12298 17; 12302 17
          klass = "Fec::Filing::#{t[0].upcase}#{t[1..-1]}".constantize
          rec = klass.find_or_initialize_by(fec_record_number: record_number, row_number: i)
          row.delete(nil)
          rec.assign_attributes row
          rec.save
          # batch[klass] ||= []
          # batch[klass] << rec
        rescue => e
          File.write(File.join(Rails.root, 'db', 'data', 'fec', 'filings', 'row_errors', "#{record_number}_#{i}"), e.inspect.to_s + "\n\n" + e.awesome_backtrace.to_s)
        end
      end

      # batch.each do |kklass, bbatch|
      #   kklass.import bbatch, on_duplicate_key_update: []  # ignore duplicates
      # end

      File.delete filing.file_path if File.exists? filing.file_path
    else
      File.write(File.join(Rails.root, 'db', 'data', 'fec', 'filings', 'not_v3', "#{record_number}"), filing.filing_version)
      File.delete filing.file_path if File.exists? filing.file_path
    end
  end
#   i=11918; @filing = nil
#   @filing = Fech::Filing.new(i, Fec::Filing::FECH_OPTIONS); @filing.download
# while(true) do Fec::Filing.download_and_save(i) && i +=1 end



  def self.dostuff filing
    print "\n", filing.filing_id, ' '
    print filing.filing_version || filing.form_type, ' '
    if filing.filing_version.to_i >= 3
      p filing.header
      p filing.summary

      filing.amends
      filing.rows_like(//).each_with_index do |row, i|
        # mapped_row = filing.map row
        t = self.base_type (row[:record_type] || row[:form_type])
        print ' ', i, ' ', t, ' ', row, "\n"
      end

    else
      # print      filing.filing_version
    end
  end

  # Runs the passed block on every downloaded .fec file.
  # Pass the same options hash as you would to Fech::Filing.new.
  # E.g. for_all(:download_dir => Rails.root.join('db', 'data', 'fec', 'filings',
  #   :csv_parser => Fech::CsvDoctor, ...) {|filing| ... }
  # filing.download is of course unnecessary.
  #
  # note that if there are a lot of files (e.g. after download_all), just listing them to prepare
  #   for this will take several seconds
  def self.for_all options = FECH_OPTIONS
    # .sort{|x| x.scan/\d+/.to_i } # should be no need to spend time on sort,
    #   since the file system should already do that
    Dir[File.join(FILES_DIR, '*.fec')].each do |file|
      filing = Fech::Filing.new(file.scan(/(\d+)\.fec/)[0][0].to_i, options)
      filing.translate do |t|
        t.convert field: /(^|_)date/ do |value|
          Date.parse(value) rescue value
        end
      end
      yield filing
    end
  end
end
