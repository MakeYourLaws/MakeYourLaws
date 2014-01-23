class User < ActiveRecord::Base
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, # :validatable, # do it better ourselves
         :encryptable, :confirmable, 
         :lockable, :timeoutable, :omniauthable, 
         :authentication_keys => [:login_or_email] #, :email, :login, :name]
  
  has_many :identities
  has_many :carts
  has_one :current_cart, -> {where(state: [:empty, :filled, :checked_out])}, class_name: 'Cart'
  
  extend FriendlyId
  friendly_id :login
  
  attr_accessor :login_or_email, :strength_mock
  
  has_paper_trail
  strip_attributes
  
  validates_presence_of :name, :login, :email
  validates_uniqueness_of :login, :email
  validates :email, :email => true
  
  validates_format_of :login, :with => /\A[a-zA-Z0-9_]+\z/i, :message => "can only have letters a-z, digits and underscores"
  validates_format_of :login, :with => /\A[a-zA-Z0-9].*\z/i, :message => "must start with letter or digit"
  validates_format_of :login, :with => /\A.*[a-zA-Z0-9]\z/i, :message => "must end with letter or digit"
  
  validates_format_of :password, :with => /\A.*[[:alpha:]].*\z/, :message => "must contain at least one letter", :if => :password_required?
  # Note: :punct: is supposed to match all punctuation, but misses =`~$^+|<>> - see http://stackoverflow.com/questions/11130490/why-does-ruby-punct-miss-some-punctuation-characters
  validates_format_of :password, :with => /\A.*[[:digit:]\s[:punct:]=`~$^+|<>>].*\z/, :message => "must contain at least one number, space, or punctuation character", :if => :password_required?
  validates_length_of :password, :minimum => 6, :if => :password_required?
  
  before_validation do
    login.downcase! if login
  end
  
  validate :validate_password_strength

  def validate_password_strength
    return true unless password_required? # only set if setting the password; it's stored as encrypted_password
    
    case self.password
      when self.email then errors.add :password, "must be different than email"
      when self.login then errors.add :password, "must be different than login"
      when self.name then errors.add :password, "must be different than name"
    end
    
    errors.add :password_confirmation, "must match" unless self.password == self.password_confirmation  
    
    unless self.strength_mock # prevent recursion
      password_excerpt = self.password.gsub(/(#{self.login}|#{self.email}|#{self.name})/i, '')
      if password_excerpt != self.password
        mock =  User.new :password => password_excerpt, :password_confirmation => password_excerpt, :login => login, :email => email
        mock.strength_mock = true
        # Note: This errror message is actually lying a bit. 
        # If your password is contains the email/login/name, but is strong by itself, that's OK. But not eg foobar/foobar1.
        errors.add :password, "must not contain email, login, or name" unless mock.valid? or mock.errors[:password].blank?
      end
    end
    true
  end
  
  def self.find_first_by_auth_conditions(tainted_conditions, opts={})
    conditions = tainted_conditions.dup
    login = conditions.delete(:login_or_email)
    if login
      if login =~ /@/
        conditions[:email] = login.strip.downcase
      else
        conditions[:login] = login.strip.downcase
      end
    end
    super conditions, opts
  end
    
  def password_required?
    !(password.blank? and password_confirmation.blank? and 
      (persisted? or !identities.empty?))
  end
  
  def update_with_password(params, *options)
    current_password = params.delete(:current_password)

    if params[:password].blank?
      params.delete(:password)
      params.delete(:password_confirmation) if params[:password_confirmation].blank?
    end
    
    result = if !password_required? or valid_password?(current_password)
      update_attributes(params, *options)
    else
      self.attributes = params
      self.valid?
      self.errors.add(:current_password, current_password.blank? ? :blank : :invalid)
      false
    end

    clean_up_passwords
    result
  end
end
