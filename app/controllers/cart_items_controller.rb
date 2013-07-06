class CartItemsController < ApplicationController
  load_and_authorize_resource :cart
  load_and_authorize_resource :through => :cart
  
  def create
    
  end
  
  def destroy 
    
  end
  
  def update
    
  end
  
end
