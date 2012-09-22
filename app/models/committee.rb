class Committee < ActiveRecord::Base
  self.inheritance_column = :_type_disabled # disable STI
  has_paper_trail
  strip_attributes
  
  belongs_to :legal_committee, :polymorphic => true
  validates_associated :legal_committee
  validates_inclusion_of :jurisdiction, :in => JURISDICTIONS
  validates_presence_of :jurisdiction, :full_name
  # incomplete
  COMMITTEE_TYPES = ["General purpose", "Small contributor", "Independent expenditure", "Non-contribution"]
  CORPORATION_TYPES = ["501(c)3", "501(c)4", "527 PAC", "527 multicandidate PAC", "527 Super PAC IEOC", "527 Hybrid Super PAC", "527 Non-PAC", "527 SSF", "527 Leadership PAC"]
  
  validates :email, :email => true
  validates :paypal_email, :email => true
  validates :url, :uri => true
  
  validate :phone_validate
  
  def phone_validate
    begin
      # normalize
      self.phone = Phoner::Phone.parse self.phone    
    rescue Phoner::AreaCodeError
      errors.add :phone, "must include area code"
    rescue 
      errors.add :phone, "is invalid"
    end
  end
  
end