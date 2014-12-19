# an agreement to which a user agrees.
#
# versioned: an agreement with the same name should be the same agreement, with its version updated to 
# indicate change
#
# the full text of the agreement goes in #full; a more human-friendly short version may go on #short.
#
# activation and expiry:
# an agreement may be activated in the future by setting activates_at to that time in the future. 
# activates_at may be set to the current time to activate immediately. 
# an agreement with a null activates_at will never activate (until its activates_at is changed)
# an agreement may expire in the future by setting expires_at to the future time.
# when the current time is past expires_at, the agreement is inactive. 
# if the agreement has a null expires_at, it is active indefinitely.
class Agreement < ActiveRecord::Base
  scope :active, -> { where("(activates_at IS NOT NULL AND activates_at < UTC_TIMESTAMP()) AND (expires_at IS NULL OR expires_at > UTC_TIMESTAMP())") }

  validates :version, :uniqueness => {:scope => :name}

  def active?
    (activates_at && activates_at.past?) && (!expires_at || expires_at.future?)
  end
end
