# a join between a user and an agreement (at a particular version) indicating the user has accepted 
# that agreement
class UsersAgreement < ActiveRecord::Base
  belongs_to :user
  belongs_to :agreement
end
