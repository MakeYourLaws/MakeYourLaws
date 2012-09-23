class Paypal::TransactionNotification < ActiveRecord::Base
  self.table_name = "paypal_transaction_notifications" # use namespaced table
  
  belongs_to :subtransaction
  
  def details
    @details ||= JSON.parse details_json
  end
  
  # def update_details!
  #   self.details_json = get_details
  #   self.status = if transaction_status == [nil]
  #     self.details['status']
  #   else
  #     transaction_status.join(', ')
  #   end
  #   save!
  # end
  
end