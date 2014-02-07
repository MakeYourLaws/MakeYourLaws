class UsersRole < ActiveRecord::Base
  belongs_to :user
  belongs_to :role
  has_paper_trail
end