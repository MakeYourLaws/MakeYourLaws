class Committee < ActiveRecord::Base
  self.inheritance_column = :_type_disabled # disable STI
  resourcify

  has_paper_trail
  strip_attributes

  belongs_to :legal_committee, polymorphic: true
  has_many :cart_items
  has_many :carts, through: :cart_items

  validates_associated :legal_committee
  validates :jurisdiction, inclusion: { in: JURISDICTIONS }, presence: true
  validates :full_name, presence: true
  validates :email, :paypal_email, email: true
  validates :url, uri: true
  validate :phone_validate

  # incomplete
  COMMITTEE_TYPES = ['General purpose', 'Small contributor', 'Independent expenditure',
                     'Non-contribution']
  CORPORATION_TYPES = ['501(c)3', '501(c)4', '527 PAC', '527 multicandidate PAC',
                       '527 Super PAC IEOC', '527 Hybrid Super PAC', '527 Non-PAC', '527 SSF',
                       '527 Leadership PAC']

  def phone_validate
    self.phone = Phoner::Phone.parse phone if phone
  rescue Phoner::AreaCodeError
    errors.add :phone, 'must include area code'
  rescue
    errors.add :phone, 'is invalid'
  end
end
