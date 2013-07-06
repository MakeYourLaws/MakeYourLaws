StripeEvent.setup do
  # subscribe 'charge.failed' do |event|
  #   # Define subscriber behavior based on the event object
  #   event.class #=> Stripe::Event
  #   event.type  #=> "charge.failed"
  #   event.data  #=> { ... }
  # end
  # 
  # subscribe 'customer.created', 'customer.updated' do |event|
  #   # Handle multiple event types
  # end

  subscribe do |event|
    puts event.inspect
    # Handle all event types - logging, etc.
  end
end

# StripeEvent.event_retriever = lambda do |params|
#   secret_key = Account.find_by_stripe_user_id(params[:user_id]).secret_key
#   Stripe::Event.retrieve(params[:id], secret_key)
# end