class User < ActiveRecord::Base
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :token_authenticatable, :encryptable, :confirmable, 
         :lockable, :timeoutable, :omniauthable

  has_many :identities

  # Setup accessible (or protected) attributes for your model
  attr_accessor :login_or_email
  attr_accessible :email, :password, :password_confirmation, :remember_me, :name, :login, :login_or_email
  
  validates_presence_of :name, :login, :email
  validates_uniqueness_of :login, :email
  validates_format_of :login, :with => /^[\w\d]+$/i, :message => "can only have letters & digits"
  validates :email, :email => true
  
  strip_attributes
  
  def self.find_for_authentication(warden_conditions)
    conditions = warden_conditions.dup
    login = conditions.delete(:login_or_email)
    where(conditions).where(["lower(login) = :value OR lower(email) = :value", { :value => :login_or_email.downcase }]).first
  end
  
  def password_required?
    (password.blank? and encrypted_password_was.blank? and !identities.empty?) ? false : true
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
