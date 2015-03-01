# an agreement may have many roles which are required for the role to be active. this table 
# indicates what agreements are required for what roles. any active version of the agreement 
# will be acceptable, so only the agreement_name is specified here, omitting agreement version.
class RolesAgreement < ActiveRecord::Base
  # active agreements for this role agreement (by name)
  def agreements
    Agreement.active.where(:name => agreement_name)
  end

  validate do
    unless agreements.any?
      errors.add :agreement_name, "must refer to an existing agreement"
    end
  end

  validates :agreement_name, :uniqueness => {:scope => :role_id, :message => "is already required for this role", :if => :role_id}
  validates :role_id, :presence => true

  # most current active agreement 
  def latest_agreement
    agreements.last
  end
  belongs_to :role
end
