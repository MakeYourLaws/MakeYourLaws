require 'rubygems'
require 'base64'
require 'json'
require 'active_support'

module Mixpanel

  # A simple function for asynchronously logging to the mixpanel.com API.
  # This function requires `curl`.
  #
  # event: The overall event/category you would like to log this data under
  # properties: A hash of key-value pairs that describe the event. Must include
  # the Mixpanel API token as 'token'
  #
  # See http://mixpanel.com/api/ for further detail.
  def track!(event, properties={})
    properties['ip'] = request.remote_ip rescue nil
    if user_signed_in?
      properties['mp_name_tag'] = current_user.email
      properties['distinct_id'] = current_user.id
    end
    properties['rails env'] = Rails.env
    logger.info "Tracked: #{event} #{properties}"

    properties['token'] = '2b2e22dcf8cd5e3db82b017a44d57442'
    params = {"event" => event, "properties" => properties}
    data = Base64.strict_encode64(JSON.generate(params))
    request = "http://api.mixpanel.com/track/?data=#{data}"
    `curl -s '#{request}' &` # TODO: Use an event queue instead
  end
end