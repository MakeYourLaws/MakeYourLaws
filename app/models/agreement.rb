class Agreement < ActiveRecord::Base
  scope :active, -> { where("(activates_at IS NOT NULL AND activates_at < UTC_TIMESTAMP()) AND (expires_at IS NULL OR expires_at > UTC_TIMESTAMP())") }

  def active?
    (activates_at && activates_at.past?) && (!expires_at || expires_at.future?)
  end
end
