# via http://www.simple10.com/resque-admin-in-rails-3-routes-with-cancan/
class IsAdmin
  def self.matches?(request)
    request.env['warden'].user.try(:is_admin?)
  end
end
