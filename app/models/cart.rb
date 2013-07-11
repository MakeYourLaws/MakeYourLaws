class Cart < ActiveRecord::Base
  belongs_to :user
  belongs_to :disbursement
  has_many :payments
  validates_presence_of :user, :cart_items_count, :state
  
  has_many :cart_items
  has_many :committees, :through => :cart_items
  
  has_paper_trail
  
  
  state_machine :initial => :empty do
    event :fill do
      transition  [:empty, :filled, :checked_out] => :filled, :if => lambda {|c| c.cart_items > 0 }
    end
    
    # Clear actually just mothballs the cart and creates a new one.
    event :clear do
      transition :filled => :abandoned, :if => lambda {|c| c.cart_items == 0 }
    end
    
    event :check_out do
      transition :filled => :checked_out, :if => lambda {|c| c.cart_items > 0 }
    end
    
    event :pay do
      transition :checked_out => :paid
    end
    
    event :refund do
      transition :paid => :filled
    end
    
    event :disburse do
      transition :paid => :disbursed
    end
    
  end 
  
  
end