class SearchResult < ActiveRecord::Base
  belongs_to :search
  belongs_to :result, polymorphic: true
end
