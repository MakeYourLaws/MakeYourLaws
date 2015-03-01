class RolesAgreement < ActiveRecord::Base
  # active agreements for this role agreement (by name)
  def agreements
    Agreement.active.where(:name => agreement_name)
  end

  # most current active agreement 
  def latest_agreement
    agreements.last
  end
  belongs_to :role
end
