class Journalist < ActiveRecord::Base
  has_many :phones, through: :phone_usages, as: :phoner
  has_many :emails, through: :email_usages, as: :emailer
  has_many :articles
end