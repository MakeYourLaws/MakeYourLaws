class EmailUsage < ActiveRecord::Base
  belongs_to :emailer, polymorphic: true
  belongs_to :email
end