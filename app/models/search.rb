class Search < ActiveRecord::Base
  has_many :search_results
  # FIXME: should have_many polymorphic
  has_many :results, through: :search_results, source_type: 'Tweet', source: :result
end
