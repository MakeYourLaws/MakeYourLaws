class Payments::Paypal::Transaction < ActiveRecord::Base
  self.table_name = 'paypal_transactions' # use namespaced table
  include Rails.application.routes.url_helpers
  has_paper_trail

  belongs_to :user
  has_many :notifications
  has_many :subtransactions

  STATUSES = %w( CREATED COMPLETED INCOMPLETE ERROR REVERSALERROR PROCESSING PENDING )

  validates :amount, numericality: { greater_then: 0 }

  monetize :amount_cents

  # response:
  # ack / success?, timestamp, build, correlation_id, request, response
  # all take arg: [method]_for token
  # embedded_flow_url
  # redirect_url
  # redirect_pre_approval_url

  def execute!
    # :error_language = 'en_US'
    if pay_key || funding_plan_id
      PAYPAL.execute_payment pay_key: pay_key, funding_plan_id: funding_plan_id
    else
      fail "Can't execute without pay_key or funding_plan_id"
    end
  end

  def details
    @details ||= JSON.parse details_json
  end

  def get_details
    # :error_language = 'en_US'
    if pay_key
      @details = nil
      PAYPAL.details_for_payment(pay_key: pay_key).json
    else
      fail "Can't get details without pay_key"
    end
  end

  def transaction_status
    details['paymentInfoList']['paymentInfo'].map { |x| x['transactionStatus'] }.uniq
  end

  def update_details!
    self.details_json = get_details
    self.status = if transaction_status == [nil]
                    details['status']
                  else
                    transaction_status.join(', ')
                  end
    self.source = details['senderEmail']

    if pay_key
      self.correlation_id = details['responseEnvelope']['correlationId']
      self.memo = details['memo']
      update_subtransactions!
      self.amount_cents = subtransactions.sum :amount_cents
    end
    save!
  end

  def update_subtransactions!
    details['paymentInfoList']['paymentInfo'].each do |subhash|
      next if subhash['transactionId'].blank?
      subtx = subtransactions.find_or_initialize_by_paypal_transaction_id(subhash['transactionId'])
      subtx.update_from_hash subhash
      subtx.user_id = user_id
      subtx.save!
    end
  end

  def addresses
    # :error_language = 'en_US'
    if pay_key
      PAYPAL.get_shipping_addresses pay_key: pay_key
    else
      fail "Can't get details without pay_key"
    end
  end

  def refund!
    if pay_key
      response = PAYPAL.refund pay_key: pay_key
      update_details!
      response
    else
      fail "Can't refund without pay_key"
    end
  end

  # convert_currency
  # :error_language => 'en_US'
  # :currency_list => [ {:amount, :code} ],
  # :to_currencies => [ {:code} ]

  def payment_options
    # :error_language = 'en_US'
    if pay_key
      PAYPAL.get_payment_options pay_key: pay_key
    else
      fail "Can't get details without pay_key"
    end
  end

  # :sender => { :share_address, :share_phone_number, :require_shipping_address_selection,
  #   :referrerCode },
  # :display_options => {:email_header_image_url, :email_marketing_image_url, :header_image_url,
  #   :business_name }
  # :receiver_options => [ {:description, :custom_id,
  #   :invoice_data => { :item => [ {:name, :identifier, :price, :item_price, :item_count} ],
  #     :total_tax, :total_shipping },
  #   :email, :phone => {
  #      :country_code, :phone_number, # required if phone present
  #      :extension }
  #   :referrer_code } ],
  def payment_options= options
    # :error_language => 'en_US',
    if pay_key
      options = { pay_key: pay_key }.merge! options
      PAYPAL.set_payment_options options
    else
      fail "Can't get details without pay_key"
    end
  end
end
