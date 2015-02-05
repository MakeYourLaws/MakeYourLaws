class CartItem < ActiveRecord::Base
  belongs_to :cart, counter_cache: true, touch: true, autosave: true, inverse_of: :cart_item
  validates :cart, presence: true

  delegate :owner, to: :cart

  # Item in cart is one of: Cart (proxy bundle), LegalIdentity.
  # In the future, it'll also include something like Contingency.

  belongs_to :item, polymorphic: true, validate: true # LegalIdentity or Cart
  validate :item, presence: true
  validate :validate_item_type
  def validate_item_type
    unless item.is_a? LegalIdentity || item.is_a? Cart
      errors.add(:item, "must be LegalIdentity or Cart")
    end
  end

  validates :short_reason, length: {in: 10..140}, allow_nil: true
  validates :weight, numericality: {greater_than: 0, only_integer: true}, presence: true
  # reason, message

  resourcify # for roles - users have permissions on profiles
  strip_attributes
  has_paper_trail
end
