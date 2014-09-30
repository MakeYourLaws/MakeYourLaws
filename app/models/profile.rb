class Profile < ActiveRecord::Base
  self.inheritance_column = :_type_disabled # disable STI

  resourcify # for roles - users have permissions on profiles

  extend FriendlyId
  # ID is in user's preferred capitalization, though uniqueness is case-insensitive
  friendly_id :handle_lowercase, use: :finders
  has_paper_trail
  strip_attributes

  has_many :carts, as: :owner
  belongs_to :legal_identity # for recipients & validated identity info

  has_attached_file :avatar, :styles => { :medium => "300x300>", :thumb => "100x100>" },
    :preserve_files => "true", :keep_old_files => 'true', # preserve evidence in case of abuse
    :default_url => "/images/profile_missing_:style.png"

  validates_attachment :avatar,
    # :presence => true,  # not required yet
    # could have type validation /\Aimage\/.*\Z/ but that's probably too loose
    :content_type => { :content_type => ["image/jpeg", "image/gif", "image/png"] },
    :size => { :in => 0..10.megabytes }

  validates :handle_lowercase, presence: true, uniqueness: true
  validates :handle, presence: true
  validates :handle, format: { with: /\A[a-zA-Z0-9_]+\z/i,
    message: 'can only have letters a-z, digits and underscores' }, allow_nil: true
  validates :handle, format: { with: /\A[a-zA-Z0-9].*\z/i,
    message: 'must start with letter or digit' }, allow_nil: true
  validates :handle, format: { with: /\A.*[a-zA-Z0-9]\z/i,
    message: 'must end with letter or digit' }, allow_nil: true
  # TODO: blacklist reserved words & routes

  before_validation do
    p "before_validation: #{self.inspect}"
    self.handle_lowercase = handle.downcase
  end

  validates :name, presence: true # profile.name is the public display name
  # validates :bio, presence: true  # minimum length?
  # TODO: platform / positions on policies
  # TODO: party & other affiliations

  # TODO: associate with Identity(s) for authenticated & linked external profiles
  # TODO: associate with official website(s) and authenticate ownership somehow
  # TODO: associate with public contact information

  # def name_validated?
  #   legal_identity && legal_identity.name == name
  # end

end
