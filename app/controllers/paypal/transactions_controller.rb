class Paypal::TransactionsController < ApplicationController
  include ActiveMerchant::Billing::Integrations::Paypal
  load_and_authorize_resource class: Payments::Paypal::Transaction
  before_action :deny_tor_users

  def index
  end

  def new
  end

  def show
    # @transaction = Payments::Paypal::Transaction.find transaction_params
    # @transaction.update_details! # IPN should take care of this
  end

  def create
    # Possible options for setup_purchase:
    #   :action_type => 'PAY'
    #   :preapproval_key, :sender_email, :memo, :custom, :fees_payer, :pin, :tracking_id
    #   :receiver_list => [ {
    #     :email, :amount,  # required
    # payment types: DIGITALGOODS
    #     :primary, :payment_type, :invoice_id}
    #   }]

    @transaction = Payments::Paypal::Transaction.create transaction_params
    data = urls.merge!(
      tracking_id:                            @transaction.id,
      reverse_all_parallel_payments_on_error: 'true',
      receiver_list:                          [
        # {:email => PAYPAL.options[:myl_c3], :amount => (@transaction.amount),
        # :currency_code => @transaction.currency},
        { email: PAYPAL.options[:myl_c4], amount: (@transaction.amount),
          currency_code: @transaction.currency }
      ]
      )
    pay_response = PAYPAL.setup_purchase data
    if pay_response.success?
      @transaction.pay_key = pay_response.pay_key
      @transaction.user_id = current_user.id if user_signed_in?
      @transaction.update_details!
      respond_to do |format|
        format.html { redirect_to PAYPAL.embedded_flow_url_for @transaction.pay_key }
        # redirect_to PAYPAL.redirect_url_for @transaction.pay_key }
        format.js
      end
    else
      logger.error pay_response.errors.first['message']
      redirect_to paypal_transaction_url(@transaction), status: 'failed'
    end
  end

  def refresh
    @transaction.update_details!
    redirect_to paypal_transaction_url(@transaction)
  end

  def destroy # refund
    # @transaction = Payments::Paypal::Transaction.find transaction_params
    response = @transaction.refund!
    if response.success?
      flash[:notice] = 'Transaction successfully refunded!'
      redirect_to @transaction
    else
      flash[:notice] = "Transaction refund failed - #{response.errors.first['message']}"
      redirect_to paypal_transaction_url(@transaction), status: 'failed'
    end
  end

  private

  def urls
    { return_url:           paypal_transaction_url(@transaction, status: 'completed'),
      cancel_url:           paypal_transaction_url(@transaction, status: 'canceled'),
      ipn_notification_url: paypal_notifications_url
    }
  end

  def transaction_params
    # attr_accessible :amount, :currency # TODO: remove this after testing
    params.require(:paypal_transaction).permit(:amount, :currency)
  end
end
