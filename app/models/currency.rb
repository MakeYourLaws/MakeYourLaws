class Currency < ActiveRecord::Base
  validates_presence_of :name, :abbreviation
end