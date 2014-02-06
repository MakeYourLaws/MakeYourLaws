# Lockout IP addresses that are hammering your login page.
# After 20 requests in 1 minute, block all requests from that IP for 1 hour.
Rack::Attack.blacklist('allow2ban login scrapers') do |req|
  # `filter` returns false value if request is to your login page (but still
  # increments the count) so request below the limit are not blocked until
  # they hit the limit.  At that point, filter will return true and block.
  Rack::Attack::Allow2Ban.filter(req.ip, :maxretry => 20, :findtime => 1.minute, :bantime => 1.hour) do
    # The count for the IP is incremented if the return value is truthy.
    req.path == '/login' and req.post?
  end
end

# Throttle requests to 5 requests per second per ip
Rack::Attack.throttle('req/ip', :limit => 5, :period => 1.second) do |req|
  # If the return value is truthy, the cache key for the return value
  # is incremented and compared with the limit. In this case:
  #   "rack::attack:#{Time.now.to_i/1.second}:req/ip:#{req.ip}"
  #
  # If falsy, the cache key is neither incremented nor checked.

  # Count all Tor IPs as the same for throttling purposes
  req.env['action_dispatch.remote_ip']  # req.ip
end