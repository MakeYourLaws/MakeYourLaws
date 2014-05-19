class Email < ActiveRecord::Base
  has_many :email_usages
  # has_many :emailers, through: :email_usages  # polymorphic
end