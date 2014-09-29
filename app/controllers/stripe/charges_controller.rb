class Payments::Stripe::ChargesController < ApplicationController
  # load_and_authorize_resource :class => Stripe::Charge
  before_action :deny_tor_users

  def new
    logger.debug @charge.inspect
    @charge = Stripe::Charge.new
  end

  def create
    logger.debug params

    logger.debug Stripe::Token.retrieve params[:stripe_id]
    render inline: 'Stuff'
  end

  private

  def charge_params
    params.require(:charge).permit(:stripe_id, :amount, :currency)
  end
end
