class Identity < ActiveRecord::Base
  belongs_to :user
  validates_presence_of :uid, :provider
  validates_uniqueness_of :uid, :scope => :provider
  strip_attributes

  has_paper_trail

  # Find or create an identity based on an Omniauth response
  # Identities can belong to users (once claimed and confirmed) but might not always
  def self.by_omniauth(auth)
    uid = (auth.provider == 'coinbase' ? auth.info.id  : auth.uid )
    id = Identity.find_or_initialize_by(:provider => auth.provider, :uid => uid)

    %w(name email nickname first_name last_name location description image phone urls).each do |x|
      id.send "#{x}=", auth.info[x]
    end
    %w(token secret).each {|x| id.send "#{x}=", auth.credentials[x] }
    id.raw_info = auth.extra.to_json

    # Special case extractions
    case auth.provider
      when 'coinbase'
        # auth.info.balance # in BTC
        # auth.extra.buy_limit.amount / auth.extra.buy_limit.currency (BTC)
        # auth.extra.sell_limit.amount / auth.extra.sell_limit.currency (BTC)
        # auth.extra.buy_level
        # auth.extra.sell_level
      when "open_id"
        id.nickname ||= auth.uid.match(/:\/\/([^.]*)./)[1] if auth.uid.include? "livejournal"
        id.url = id.uid
      when "google"
        if id.name =~ /@/ # don't accept email addresses as a "name"
          id.nickname ||= id.name.split('@').first
          id.name = nil
        end
        id.url = auth.extra["raw_info"]["link"]
      when "github"
        id.url = id.urls["GitHub"] if id.urls
      when "facebook"
        id.url = id.urls["Facebook"] if id.urls
      when "twitter"
        id.url = id.urls["Twitter"] if id.urls
      when "paypal"
        id.nickname = id.email
    end

    id.nickname ||= id.email.split('@').first if id.email

    id.save

    id
  end

  def display_name
    if name
      nickname ? "#{name} (#{nickname})" : name
    else
      email || uid
    end
  end
end
