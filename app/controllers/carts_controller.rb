class CartsController < ApplicationController
  load_and_authorize_resource
  
  # Admins only
  def index
  end
  
  # Default to current user's current cart
  def show
  end
  
  # Actually just mothballs
  def destroy 
    
  end  
end
