require 'addressable/uri'

class Link < ActiveRecord::Base
  belongs_to :duplicate_of, class_name: Link
  # nil until unshortened, = self if canonical

  has_many :duplicates, class_name: Link, as: :duplicate_of

  before_save :clean_url

  def self.add_by_url url
    self.find_or_create_by(url: Link.clean_url(url))
  end

  def self.clean_url url
    url = url.sub(/^HTTP:\/\/http/i, 'http').sub(/:\/\/[\/]+/, '://')
    if url.size > 255
      uri = Addressable::URI.parse(url)
      uri.query_values = []
      url = uri.to_s.sub(/\?$/,'')
    end
    url
  end

  def clean_url
    self.url = Link.clean_url(url)
  end

  def uncrufted
    uri = Addressable::URI.parse(self.url)

    blacklist = %w(utm_source utm_medium utm_term utm_content utm_campaign s_campaign dlvrit utm_cid refid feature hp)
    params = uri.query_values
    if params
      blacklist.each{|w| params.delete w}
      uri.query_values = params
    end

    uri.to_s.sub(/\?$/,'')
  end

end
