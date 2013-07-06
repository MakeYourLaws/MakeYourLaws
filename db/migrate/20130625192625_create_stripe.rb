class CreateStripe < ActiveRecord::Migration
  def change
    create_table :stripe_charges do |t|
      t.string :stripe_id
      t.boolean :test # !livemode
      t.integer :amount
      t.boolean :captured
      t.references :stripe_card
      
      t.datetime :stripe_created_at
      t.string :currency, :length => 3, :default => 'usd'
      t.integer :fee_amount # cents
      t.references :stripe_fee

      t.boolean :paid
      t.boolean :refunded # fully - false if partial
      t.integer :amount_refunded
      
      t.references :stripe_customer # ours, not stripe's
      t.string :description
      
      # "incorrect_number", "invalid_number", "invalid_expiry_month", "invalid_expiry_year", "invalid_cvc", "expired_card", "incorrect_cvc", "incorrect_zip", "card_declined", "missing", "processing_error"
      t.string :failure_code, :length => 20
      t.string :failure_message
      
      t.references :stripe_invoice
      
      t.timestamps
    end
    
    create_table :stripe_cards do |t|
      t.integer :exp_month, :null => false, :limit => 1 # bytes, 127
      t.integer :exp_year, :null => false, :limit => 2 # bytes, 32767
      t.string :fingerprint, :null => false
      t.string :last4, :null => false, :limit => 4
      t.string :type, :null => false, :limit => 20
      
      t.string :address_city, :address_country, :address_line1, :adress_line2, :address_state, :address_zip
      
      # true, false, null instead of pass, fail, unchecked
      t.boolean :address_line1_check, :address_zip_check, :cvc_check 
      
      t.string :country, :limit => 2 # CC's country, as opposed to address'
      t.string :name

      t.timestamps
    end
    
    create_table :stripe_fees do |t|
      t.integer :amount, :null => false
      t.string :currency, :limit => 3, :null => false, :default => 'usd'
      t.string :type, :null => false
      t.integer :amount_refunded
      t.string :application
      t.string :description

      t.timestamps
    end
    
    create_table :stripe_customers do |t|
      t.string :stripe_id, :null => false
      
      t.boolean :test, :null => false # !livemode
      t.datetime :stripe_created_at, :null => false
      t.integer :account_balance, :null => false, :default => 0
      t.references :stripe_card, :null => false # active_card; technically not required
      t.boolean :delinquent, :null => false, :default => false
      t.string :description
      t.references :stripe_discount
      t.string :email
      t.references :stripe_subscription
      t.boolean :deleted # on Stripe
      
      t.timestamps
    end
    
    create_table :stripe_disputes do |t|
      t.boolean :test, :null => false # !livemode
      t.integer :amount, :null => false
      t.references :stripe_charge, :null => false
      t.datetime :stripe_created_at, :null => false
      t.string :currency, :limit => 3, :null => false, :default => 'usd'
      t.string :reason, :limit => 25, :null => false # duplicate, fraudulent, subscription_canceled, product_unacceptable, product_not_received, unrecognized, credit_not_processed, general
      t.string :status, :null => false, :limit => 15 # won, lost, needs_response, under_review
      t.text :evidence, :limit => 1000 # or 444, depending on something
      t.datetime :evidence_due_by
      
      t.timestamps
    end
    
    create_table :stripe_invoices do |t|
      t.string :stripe_id, :null => false
      t.boolean :test, :null => false # !livemode
      t.integer :amount_due, :null => false
      t.integer :attempt_count, :null => false, :defualt => 0
      t.boolean :attempted, :null => false, :default => false
      t.boolean :closed, :null => false, :default => false
      t.string :currency, :limit => 3, :null => false, :default => 'usd'
      
      t.references :stripe_customer
      t.datetime :date
      t.boolean :paid, :null => false, :default => false
      t.datetime :period_end, :null => false
      t.datetime :period_start, :null => false
      t.integer :starting_balance, :null => false
      t.integer :subtotal, :null => false # pre discount
      t.integer :total, :null => false
      
      t.references :stripe_charge
      t.references :stripe_discount
      t.integer :ending_balance # null if not attempted yet
      t.datetime :next_payment_attempt
      
      t.timestamps
    end
    
    create_table :stripe_invoice_lines do |t|
      t.references :stripe_invoice_id
      t.references :stripe_customer_id, :null => false
      t.string :stripe_id
      t.boolean :test, :null => false # !livemode
      t.integer :amount, :null => false
      t.string :currency, :null => false, :length => 3, :default => 'usd'
      t.string :type, :limit => 15 # invoiceitem, subscription
      t.string :description
      
      # if subscription
      t.references :stripe_plan
      t.integer :quantity
      t.datetime :period_start
      t.datetime :period_end
      t.boolean :proration
    end
    
    create_table :stripe_discounts do |t|
      t.references :stripe_coupon, :null => false
      t.references :stripe_customer, :null => false
      t.datetime :start, :null => false
      t.datetime :end
      
      t.timestamps
    end
    
    create_table :stripe_subscriptions do |t|
      t.boolean :cancel_at_period_end, :null => false, :default => false
      t.references :stripe_customer, :null => false
      t.references :stripe_plan, :null => false
      t.integer :quantity, :null => false, :default => 1
      t.datetime :start, :null => false
      t.string :status, :null => false, :limit => 10 # trialing, active, past_due, canceled, unpaid
      t.datetime :canceled_at
      t.datetime :current_period_end, :null => false
      t.datetime :current_period_start, :null => false
      t.datetime :ended_at
      t.datetime :trial_end
      t.datetime :trial_start
      
      t.timestamps
    end
    
    create_table :stripe_plans do |t|
      t.string :stripe_id, :null => false # ID of our choice
      t.boolean :test, :null => false # !livemode
      t.integer :amount, :null => false
      t.string :currency, :null => false, :limit => 3, :default => 'usd'
      t.string :interval, :null => false, :limit => 5 # week, month, year
      t.integer :interval_count, :null => false, :default => 1
      t.string :name, :null => false
      t.integer :trial_period_days
      
      t.timestamps
    end
    
    create_table :stripe_coupons do |t|
      t.string :stripe_id, :null => false # coupon code
      t.boolean :test, :null => false # !livemode
      t.string :duration, :null => false # forever, once, repeating
      t.integer :amount_off
      t.string :currency, :limit => 3, :default => 'usd'
      t.integer :duration_in_months # if duration repeating
      t.integer :max_redemptions 
      t.integer :percent_off, :limit => 1 # bytes, 127
      t.datetime :redeem_by
      t.integer :times_redeemed, :null => false, :default => 0
      
    end
    
    create_table :stripe_transfers do |t|
      t.string :stripe_id, :null => false
      t.boolean :test, :null => false # !livemode
      t.integer :amount, :null => false
      t.string :currency, :limit => 3, :null => false, :default => 'usd'
      t.datetime :date, :null => false
      t.integer :fee, :null => false
      t.string :status, :null => false, :limit => 10 # paid, pending, failed
      t.string :description
      t.references :stripe_recipient
      t.string :statement_descriptor
    end
    
    create_table :stripe_bank_accounts do |t|
      t.string :stripe_id, :null => false
      t.string :bank_name
      t.string :country, :limit => 2
      t.string :last4
      t.string :fingerprint
      t.boolean :validated
    end
    
    create_table :stripe_recipients do |t|
      t.string :stripe_id, :null => false
      t.boolean :test, :null => false # !livemode
      t.datetime :stripe_created_at # created
      t.string :type, :limit => 15  # individual, corporation
      t.references :stripe_bank_account # active_account
      t.string :description
      t.string :email
      t.string :name
    end
    
    create_table :stripe_accounts do |t|
      t.string :stripe_id, :null => false
      t.boolean :charge_enabled, :null => false
      t.string :currencies_enabled, :null => false # "['usd', 'can', ...]"
      t.boolean :details_submitted, :null => false
      t.boolean :transfer_enabled, :null => false
      t.string :email, :null => false
      t.string :statement_descriptor
    end
    
    # balance
    # balance_transaction
    
    create_table :stripe_events do |t|
      t.string :stripe_id, :null => false
      t.boolean :test, :null => false # !livemode
      t.datetime :stripe_created_at, :null => false
      t.integer :pending_webhooks, :null => false, :default => 0
      # "account.updated", "account.application.deauthorized", "balance.available", "charge.succeeded", "charge.failed", "charge.refunded", "charge.captured", "charge.dispute.created", "charge.dispute.updated", "charge.dispute.closed", "customer.created", "customer.updated", "customer.deleted", "customer.subscription.created", "customer.subscription.updated", "customer.subscription.deleted", "customer.subscription.trial_will_end", "customer.discount.created", "customer.discount.updated", "customer.discount.deleted", "invoice.created", "invoice.updated", "invoice.payment_succeeded", "invoice.payment_failed", "invoiceitem.created", "invoiceitem.updated", "invoiceitem.deleted", "plan.created", "plan.updated", "plan.deleted", "coupon.created", "coupon.deleted", "transfer.created", "transfer.updated", "transfer.paid", "transfer.failed", "ping"
      t.string :type
      t.string :request
      
      t.text :object
      t.text :previous_attributes
    end
    
    
  end
end
