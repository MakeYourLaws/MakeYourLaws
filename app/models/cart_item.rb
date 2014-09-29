class CartItem < ActiveRecord::Base
  belongs_to :cart, counter_cache: true
  belongs_to :committee
  validates :cart_id, :committee_id, presence: true
  delegate :user, to: :cart

  has_paper_trail
end
