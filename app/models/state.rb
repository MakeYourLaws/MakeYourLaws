class State < ActiveRecord::Base
  validates_uniqueness_of :abbreviation, :scope => :country
  validates_uniqueness_of :name, :scope => :country
  validates_presence_of :name, :country
end
