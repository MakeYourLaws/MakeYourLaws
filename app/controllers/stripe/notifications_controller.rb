StripeEvent.configure do |events|
  events.subscribe 'charge.failed' do |event|
    # Define subscriber behavior based on the event object
    event.class       #=> Stripe::Event
    event.type        #=> "charge.failed"
    event.data.object #=> #<Stripe::Charge:0x3fcb34c115f8>
  end

  class BillingEventLogger
    def initialize(logger = nil)
      @logger = logger || begin
        require 'logger'
        Logger.new($stdout)
      end
    end

    def call(event)
      @logger.info "BILLING-EVENT: #{event.type} #{event.id}"
    end
  end
  events.all BillingEventLogger.new(Rails.logger)
  
  events.all do |event|
    # Handle all event types - logging, etc.
  end
end

# StripeEvent.event_retriever = lambda do |params|
#   api_key = Account.find_by!(stripe_user_id: params[:user_id]).api_key
#   Stripe::Event.retrieve(params[:id], api_key)
# end