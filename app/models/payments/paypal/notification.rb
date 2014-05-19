class Payments::Paypal::Notification < ActiveRecord::Base
  self.table_name = "paypal_notifications" # use namespaced table

  # :transaction is now reserved by ActiveRecord
  belongs_to :paypal_transaction, :class => Payments::Paypal::Transaction

  def details
    @details ||= JSON.parse details_json
  end


  def transaction_status
    details['paymentInfoList']['paymentInfo'].map{|x| x['transactionStatus']}.uniq
  end

  def update_details!
    self.details_json = get_details
    self.status = if transaction_status == [nil]
      self.details['status']
    else
      transaction_status.join(', ')
    end
    save!
  end

end
