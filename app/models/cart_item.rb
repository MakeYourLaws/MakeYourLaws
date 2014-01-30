class CartItem < ActiveRecord::Base
  belongs_to :cart, :counter_cache => true
  belongs_to :committee
  validates_presence_of :cart_id, :committee_id
  delegate :user, :to => :cart
  delegate :user_id, :to => :cart
  
  has_paper_trail
  
  
end