class FecAoDocs < ActiveRecord::Base
# rails g migration fec_ao_docs name:string saos_id:string submitted:date url:string size:string fec_ao_id:reference

  belongs_to :fec_ao

  @m = Mechanize.new
  @aoinfo = {}
  @aospage = @m.get('http://saos.fec.gov/saos/searchao')
  @aosform = aospage.form('form1')


  def full_name
    fec_ao.name + ' ' + name
  end

  def self.parse_aos aos
    aonumbers = aos.links.map(&:href).select{|l| l=~ /javascript:ao\(/}.map{|l|l.strip.gsub(/[^0-9_]/,'')}
    docs = aos.links.map(&:href).select{|l| l=~ /javascript:ao1\(/}.map{|l| l[/\([0-9]+.*[0-9_]+/].split(",").map{|l|l.strip.gsub(/[^0-9_]/,'')}}
    docinfo = docs.map do |d|
      aoname = aos.links_with(:href => /javascript:ao\(.*#{d[0]}/).map(&:text).join(' ').squeeze(' ')
      docname = aos.links_with(:href => /javascript:ao1\(.*#{d[1]}/).map(&:text).join(' ').squeeze(' ')
      docurl = "http://saos.fec.gov/aodocs/#{d[1]}.pdf"
      @aoinfo[d[0]] ||= {:docs => {}}
      @aoinfo[d[0]][:name] = aoname
      @aoinfo[d[0]][:docs][d[1]] ||= {}
      @aoinfo[d[0]][:docs][d[1]][:url] = docurl
      @aoinfo[d[0]][:docs][d[1]][:name] = docname
      # [aoname, docname, docurl]
    end

    aonumbers.each do |aonumber|
      aopage = @m.get "http://saos.fec.gov/saos/aodetails.jsp?AO=#{aonumber}"
      aopage.search('div#fullview-minus-topbutton').search('nobr').map do |item|
        href = item.search('a').map{|a| a.attributes['href'].value}
        docnumber = item.search('a').map{|a| a.attributes['href'].value}.select{|l| l=~/aodocs/}.first[/[0-9_]+/]
        lasttext = item.children.last.text.gsub("\u00A0", ' ')  # "\u00A0" = &nbsp;
        info = lasttext.strip.squeeze(' ').split(/\(|\)/).map(&:strip).uniq - [""]
        next if info.size == 1
        @aoinfo[aonumber][:docs][docnumber][:url] = "http://saos.fec.gov#{href.first}"
        @aoinfo[aonumber][:docs][docnumber][:date] = Date.strptime(info[0], '%m/%d/%Y')
        @aoinfo[aonumber][:docs][docnumber][:size] = info[1]
      end
    end

    @aoinfo  # TODO: save to db in bulk
  end

  def self.get_historical
    (1975..(Date.today.year)).each do |year|
      @aosform.action = "searchao?SUBMIT=year&YEAR=#{year}"
      aos = @m.submit(@aosform)
      parse_aos aos
    end
  end

  def self.get_pending
    @aosform.action = 'searchao?SUBMIT=pending'
    aos = @m.submit(@aosform)
    parse_aos aos
  end

  def self.get_this_year
    @aosform.action = "searchao?SUBMIT=year&YEAR=#{Date.today.year}"
    aos = @m.submit(@aosform)
    parse_aos aos
  end
end