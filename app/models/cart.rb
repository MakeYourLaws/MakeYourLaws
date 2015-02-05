class Cart < ActiveRecord::Base
  belongs_to :owner, polymorphic: true # User or Profile
  # has_many :transactions
  validates :user, :cart_items_count, :state, presence: true

  # counter_cache set on CartItem
  has_many :cart_items, -> {includes :item}, inverse_of: :cart,
    autosave: true, dependent: :destroy
  validates_associated :cart_items
  # has_many :items, through: :cart_items, polymoprhic: true # doesn't work :(
  has_many :legal_identity_items, through: :cart_items, source: :item, source_type: 'LegalIdentity'
  has_many :bundle_items, through: :cart_items, source: :item, source_type: 'Cart'

  validates :short_reason, length: {in: 10..1000}, allow_nil: true
  # name, reason

  resourcify # for roles - users have permissions on profiles
  strip_attributes
  has_paper_trail

  # TODO: Move most of this state into transactions. Carts per se have a different lifecycle.
  # state_machine initial: :empty do
  #   event :fill do
  #     transition [:empty, :filled, :checked_out] => :filled, :if => ->(c) { c.cart_items > 0 }
  #   end
  #
  #   # Clear actually just mothballs the cart and creates a new one.
  #   event :clear do
  #     transition filled: :abandoned, if: ->(c) { c.cart_items == 0 }
  #   end
  #
  #   event :check_out do
  #     transition filled: :checked_out
  #   end
  #
  #   event :publish do
  #     transition [:filled, :checked_out, :recurring, :paid] => :published
  #   end
  #
  #   event :recur do
  #     transition checked_out: :recurring
  #   end
  #
  #   event :pay do
  #     transition checked_out: :paid
  #   end
  #
  #   # event :refund do
  #   #   transition paid: :filled
  #   # end
  #
  #   # event :disburse do
  #   #   transition paid: :disbursed
  #   # end
  #
  # end
end
