class Fec::Filing::Text < ActiveRecord::Base
  self.table_name = 'fec_filing_text'
  strip_attributes
end