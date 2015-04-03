class Fec::Filing
  FILES_DIR = Rails.root.join('db', 'data', 'fec', 'filings')
  SENATE_FILES_DIR = Rails.root.join('db', 'data', 'fec', 'senate_filings')
  FECH_OPTIONS = { translate: [:names], csv_parser: Fech::CsvDoctor}

  [FILES_DIR, SENATE_FILES_DIR].each do |base_dir|
    %w(errors row_errors http_error not_v3 /).each do |sub_dir|
      dirname = File.join(base_dir, sub_dir)
      FileUtils.mkdir_p(dirname) unless File.directory?(dirname)
    end
  end

  def self.base_type row_type
    FechUtils::ROW_TYPES.sort{|x,y| y[1].to_s.length <=> x[1].to_s.length }.find{|k,v| k if row_type =~ v }.first
  end

  def self.fix_errors record_type = 'C', recs = []
    if record_type == 'C'
      files_dir = FILES_DIR
    elsif record_type == 'S'
      files_dir = SENATE_FILES_DIR
    else
      raise 'Unknown FEC record type'
    end
    if recs == []
      rowerrors = `egrep "(col_a_total_receipts_period|index' on nil:NilClass|support_oppose_code|cadidate_prefix|ConnectionNotEstablished|Bad file descriptor' on nil:NilClass|ENOENT|HTTPError)" #{files_dir}/errors/* #{files_dir}/row_errors/*  | egrep -o '/fec/[^0-9]*[0-9_]+[^0-9_]*' | egrep -o '[0-9_]+' | sort | uniq`
      (rowerrors.split("\n") - ['_']).map{|r| n1, n2 = r.split('_').map(&:to_i); recs << n1}
      recfiles = `ls #{files_dir}/*.fec | egrep -o "[0-9]+"`
      recs += recfiles.split("\n").map(&:to_i)
      recs = recs.uniq

      puts recs.to_s
    end

    recs_dup =recs.dup
    recs.each do |record_number|
      begin
        print " : r#{record_number}"
        file_path = File.join(files_dir, "#{record_number}.fec")
        custom_file_path = File.join(files_dir, "fech_#{record_number}.fec")
        file_error_path = File.join(files_dir, 'errors', record_number.to_s)
        http_error_path = File.join(files_dir, 'http_error', "#{record_number}")
        File.delete(http_error_path) if File.exists?(http_error_path)
        File.delete(file_error_path) if File.exists?(file_error_path)
        self.download_and_save record_number, record_type
        recs_dup.delete(record_number)
        File.delete(file_path) if File.exists?(file_path)
        File.delete(custom_file_path) if File.exists?(custom_file_path)
      rescue => e
        puts "erroring: #{record_number}, #{file_path}"
        File.write(file_error_path, e.inspect.to_s + "\n\n" + e.awesome_backtrace.to_s)
        # puts e.inspect.to_s + "\n\n" + e.awesome_backtrace.to_s
        File.delete(file_path) if File.exists? file_path
        File.delete(custom_file_path) if File.exists?(custom_file_path)
      end
    end

    recs_dup
  end

  # from=1; x=nil;
  # Fech::Filing.for_all(Fec::Filing::FECH_OPTIONS.merge(:from=> from)) {|filing|
  #   x=filing; Fec::Filing.dostuff filing }
  def self.update_database record_type = 'C'
    if record_type == 'C'
      record_number = Fec::Filing::Hdr.maximum(:fec_record_number) || Fech::Filing::FIRST_V3_FILING
      record_number -= 4
      files_dir = Fec::Filing::FILES_DIR
    elsif record_type == 'S'
      files_dir = Fec::Filing::SENATE_FILES_DIR
      record_number = -1
    else
      raise 'Unknown FEC record type'
    end
    threads = []
    while(true) do
      # FIXME: add break condition when reaching last record
      threads.delete_if{|t| !t.alive?}
      if threads.select{|t| t.alive?}.count < 1
        record_number += 1
        threads << Thread.new do
          ActiveRecord::Base.establish_connection
          begin
            print ' ' + record_number.to_s
            Fec::Filing::download_and_save record_number
          rescue => e
            File.write(File.join(files_dir, 'errors', "#{record_number}"), e.inspect.to_s + "\n\n" + e.awesome_backtrace.to_s)
            file_path = File.join(files_dir, "#{record_number}.fec")
            custom_file_path = File.join(files_dir, "fech_#{record_number}.fec")
            File.delete(file_path) if File.exists? file_path
            File.delete(custom_file_path) if File.exists?(custom_file_path)
          end
        end
      end
    end
  end

  def self.download_and_save record_number, record_type = 'C'
    case record_type
    when 'C'
      files_dir = Fec::Filing::FILES_DIR
      filing = Fech::Filing.new(record_number, Fec::Filing::FECH_OPTIONS.merge(download_dir: files_dir))
    when 'S'
      files_dir = Fec::Filing::SENATE_FILES_DIR
      filing = Fech::SenateFiling.new(record_number, Fec::Filing::FECH_OPTIONS.merge(download_dir: files_dir))
    end
    filing.translate do |t|
      t.convert field: /percent/ do |value|
        if value.is_a?(String) && value[0] == '.'
          value.to_d
        end
      end
      t.convert field: /(^|_)date/ do |value|
        unless value.nil?
          Date.parse(value) rescue value
        end
      end
    end

    http_error_file = File.join(files_dir, 'http_error', "#{record_number}")
    begin
      File.delete(http_error_file) if File.exists?(http_error_file)
      filing.download
    rescue OpenURI::HTTPError => e
      File.write(http_error_file, e.inspect.to_s + "\n\n" + e.awesome_backtrace.to_s)
      File.delete(filing.file_path) if File.exists?(filing.file_path)
      File.delete(filing.custom_file_path) if File.exists?(filing.custom_file_path)
      return false
    end

    if filing.filing_version.to_i >= 3
      # batch = {}
      filing.each_row_with_index do |raw_array, i|
        begin
          row_error_file = File.join(files_dir, 'row_errors', "#{record_number}_#{i}")
          row = filing.map(raw_array, Fec::Filing::FECH_OPTIONS)
          if row.empty?
            File.delete(row_error_file) if File.exists?(row_error_file)
            next
          end
          print ' ' + i.to_s
          # mapped_row = filing.map row
          t = self.base_type (row[:rec_type] || row[:record_type] || row[:form_type]) ||
           (row[:form_type] = row.delete(:ballot_local_candidates)) # Some records are malformed,
                                                # eg 12104 row 536; 12164 5; 12298 17; 12302 17
          klass = "Fec::Filing::#{t[0].upcase}#{t[1..-1]}".constantize
          rec = klass.find_or_initialize_by(fec_record_number: record_number, row_number: i, fec_record_type: record_type)
          row.delete(nil)
          rec.assign_attributes row
          rec.save
          # batch[klass] ||= []
          # batch[klass] << rec
          File.delete(row_error_file) if File.exists?(row_error_file)
        rescue => e
          File.write(row_error_file, e.inspect.to_s + "\n\n" + e.awesome_backtrace.to_s)
        end
      end

      # batch.each do |kklass, bbatch|
      #   kklass.import bbatch, on_duplicate_key_update: []  # ignore duplicates
      # end

      File.delete(filing.file_path) if File.exists? filing.file_path
      File.delete(filing.custom_file_path) if File.exists?(filing.custom_file_path)
    else
      File.write(File.join(files_dir, 'not_v3', "#{record_number}"), filing.filing_version)
      File.delete(filing.file_path) if File.exists? filing.file_path
      File.delete(filing.custom_file_path) if File.exists?(filing.custom_file_path)
    end
  end

  # # Runs the passed block on every downloaded .fec file.
  # # Pass the same options hash as you would to Fech::Filing.new.
  # # E.g. for_all(:download_dir => Rails.root.join('db', 'data', 'fec', 'filings',
  # #   :csv_parser => Fech::CsvDoctor, ...) {|filing| ... }
  # # filing.download is of course unnecessary.
  # #
  # # note that if there are a lot of files (e.g. after download_all), just listing them to prepare
  # #   for this will take several seconds
  # #
  # # Special option: :from => integer or :from => range will only process filing #s starting from / within the argument
  # def self.for_all options = FECH_OPTIONS
  #   # .sort{|x| x.scan/\d+/.to_i } # should be no need to spend time on sort,
  #   #   since the file system should already do that
  #   from = options.delete :from
  #   raise ArgumentError, ":from must be Integer or Range" if from and !(from.is_a?(Integer) or from.is_a?(Range))
  #   Dir[File.join(options[:download_dir], '*.fec')].each do |file|
  #     n = file.scan(/(\d+)\.fec/)[0][0].to_i
  #     if from.is_a? Integer
  #       next unless n >= from
  #     elsif from.is_a? Range
  #       next unless n.in? from
  #     end
  #     filing = Fech::Filing.new(n, options)
  #     filing.translate do |t|
  #       t.convert field: /(^|_)date/ do |value|
  #         if value.nil?
  #           nil
  #         else
  #           Date.parse(value) rescue value
  #         end
  #       end
  #     end
  #     yield filing
  #   end
  # end
  #
  # # This downloads ALL the filings.
  # #
  # # Because this trashes the zip files after extraction (to save space), while it is safe to rerun, it has to do the whole thing over again.
  # # Update operations should just iterate single file downloads starting from the current+1th filing number.
  # #
  # # This takes a very long time to run - on the order of an hour or two, depending on your bandwidth.
  # #
  # # WARNING: As of July 9, 2012, this downloads 536964 files (25.8 GB), into one directory.
  # # This means that the download directory will break bash file globbing (so e.g. ls and rm *.fec will not work).
  # # If you want to get all of it, make sure to download only to a dedicated FEC filings directory.
  # def self.download_all options = FECH_OPTIONS
  #  `cd #{download_dir} && ftp -a ftp.fec.gov:/FEC/electronic/*.zip`
  #  `cd #{download_dir} && for z in *.zip; do unzip -o $z && rm $z; done`
  #  Dir[File.join(options[:download_dir], '*.fec')].count
  # end

end
