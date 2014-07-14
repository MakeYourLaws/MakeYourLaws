class Payments::Coinbase::Button < ActiveRecord::Base
  self.table_name = "coinbase_buttons" # use namespaced table
  include Rails.application.routes.url_helpers
  has_paper_trail

  self.inheritance_column = nil # has 'type' column that's not meant for STI

  has_many :coinbase_orders
end