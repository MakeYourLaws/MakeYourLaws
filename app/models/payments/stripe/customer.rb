class Payments::Stripe::Customer < ActiveRecord::Base
  self.table_name = "stripe_customers" # use namespaced table
  include Rails.application.routes.url_helpers
  has_paper_trail
  
  belongs_to :user

  # t.string :stripe_id, :null => false
  # t.boolean :test, :null => false # !livemode
  # t.datetime :stripe_created_at, :null => false
  # t.integer :account_balance, :null => false, :default => 0
  # t.references :stripe_card, :null => false # active_card
  # t.boolean :delinquent, :null => false, :default => false
  # t.string :description
  # t.references :stripe_discount
  # t.string :email
  # t.references :stripe_subscription

  def add token, options = {}
    # options: coupon, email, description, account_balance, 
      # plan, trial_end, quantity # subscription related
    options[:card] = token # obtained with Stripe.js
    customer = Stripe::Customer.create( options )
  end
  
  def update stripe_id, options = {}
    customer = Stripe::Customer.retrieve(stripe_id)
    # cu.description = "Customer for test@example.com"
    # cu.card = "tok_1RS9O3cqeDszgd" # obtained with Stripe.js
    customer.save
  end

end
