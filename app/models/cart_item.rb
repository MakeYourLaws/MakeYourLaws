class CartItem < ActiveRecord::Base
  belongs_to :cart, :counter_cache => true
  belongs_to :committee
  validates_presence_of :cart_id, :committee_id
  delegate :user, :to => :cart
  
  attr_accessible :total_cents, :currency
  has_paper_trail
  
  
end