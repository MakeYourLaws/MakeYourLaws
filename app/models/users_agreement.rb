class UsersAgreement < ActiveRecord::Base
  belongs_to :user
  belongs_to :agreement
end
