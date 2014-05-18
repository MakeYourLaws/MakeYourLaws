require 'addressable/uri'

class Link < ActiveRecord::Base
  belongs_to :duplicate_of, class_name: Link
  # nil until unshortened, = self if canonical

  has_many :duplicates, class_name: Link, as: :duplicate_of

  before_save :clean_url

  def self.add_by_url url
    self.find_or_create_by(url: Link.clean_url(url))
  end

  def self.add_with_hint short, long = nil
    bestlink = nil
    shortlink = Link.add_by_url(short)
    if long
      uncoiled = Uncoil.expand(long).long_url
      if uncoiled != long
        bestlink = Link.add_by_url(uncoiled)
        longlink = Link.add_by_url(long)
        longlink.update_attribute :duplicate_of_id, bestlink.id
      else
        bestlink = Link.add_by_url(long)
      end
    else
      bestlink = shortlink
    end

    if bestlink.uncrufted != bestlink.url
      uncruftedlink = Link.add_by_url(bestlink.uncrufted)
      bestlink.update_attribute :duplicate_of_id, uncruftedlink.id
      bestlink = uncruftedlink
    end

    bestlink = shortlink if !bestlink
    bestlink.update_attribute :duplicate_of_id, bestlink.id

    # needs to be updated post creation to get its own link
    shortlink.update_attribute(:duplicate_of_id, bestlink.id)
    bestlink
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
    fragment = uri.fragment
    if fragment
      uri.fragment = fragment.sub(/\.[a-zA-Z0-9-_]*\.twitter/, '')
    end

    uri.to_s.sub(/\?$/,'')
  end

end
