class Payments::Amazon::Transaction < ActiveRecord::Base
  self.table_name = "amazon_transactions" # use namespaced table
  has_paper_trail
  
  
  def cancel
    response = AmazonFlexPay::API::cancel(transaction_id, description: 'foo')
    response.transaction_id
    response.transaction_status
    
    # Errors: 
    # AccessFailure
    # AccountClosed
    # AuthFailure
    # ConcurrentModification
    # InternalError
    # InvalidClientTokenId
    # InvalidParams
    # InvalidTransactionState
    # SignatureDoesNotMatch
  end
  
  def dostuff
    
    response = AmazonFlexPay::API::get_recipient_verification_status(recipient_token_id)
    response.recipient_verification_status
    # Errors: InternalError, InvalidAccountState, InvalidParams, InvalidTokenId, TokenNotActive
  end
  
  def pay
    
  end
  
  
  
end