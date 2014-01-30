class CartsController < ApplicationController
  load_and_authorize_resource
  
  # Admins only
  def index
  end
  
  # Default to current user's current cart
  def show
  end
  #   def show args
  #     user    = args[:user]
  #     @cart = user ? (user.current_cart || user.carts.new) : Cart.new
  # p 'show'
  # p user
  # p @cart    
  #     render
  #   end
  
  # Actually just mothballs
  def destroy 
    
  end  
  
  private
  
  def cart_params
    params.require(:cart).permit(:total_cents, :currency)
  end
  
end
