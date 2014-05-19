class PhoneUsage < ActiveRecord::Base
  belongs_to :phoner, polymorphic: true
  belongs_to :phone
end