class Payments::Coinbase::Order < ActiveRecord::Base
  self.table_name = "coinbase_orders" # use namespaced table
  include Rails.application.routes.url_helpers
  has_paper_trail

  belongs_to :coinbase_button
end