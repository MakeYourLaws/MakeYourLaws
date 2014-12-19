class UsersRole < ActiveRecord::Base
  belongs_to :user
  belongs_to :role
  has_paper_trail

  # agreements needed for the role to be active for the user 
  def needed_agreements
    role.roles_agreements.reject do |roles_agreement|
      roles_agreement.agreements.any? do |agreement|
        user.agreements.include?(agreement)
      end
    end.map(&:latest_agreement)
  end
end
