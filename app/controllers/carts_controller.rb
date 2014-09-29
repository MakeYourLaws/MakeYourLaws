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

  private

  def cart_params
    params.require(:cart).permit(:total_cents, :currency)
  end
end
