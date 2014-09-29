class CartItemsController < ApplicationController
  load_and_authorize_resource :cart
  load_and_authorize_resource through: :cart

  #   def new args
  # p 1
  #     user    = args[:user]
  #     @cart = user ? (user.current_cart || user.carts.new) : Cart.new
  #     @committee = args[:committee]
  # p user
  # p user.current_cart
  # p @cart
  # p 'compare'
  # p @cart.committees
  # p @committee
  #     @present = @committee and @cart.committees.include?(@committee)
  # p 'present', @present
  #
  #     render
  #   end
  #
  def create
    @cart = current_cart || (current_user ? current_user.carts.build : Cart.build)
    @cart.new_record? ? authorize!(:create, @cart) : authorize!(:update, @cart)
    @committee = Committee.find params[:committee_id]
    ci = @cart.cart_items.build :committee_id => @committee.id
    authorize! :create, ci
    @cart.save!
    session[:cart] = @cart

    redirect_to @committee # FIXME: only if added from the committee page; handle AJAX version
  end

  def destroy
  end

  def update
  end

  private

  def cart_item_params
    params.require(:cart_item).permit(:total_cents, :currency)
  end
end
