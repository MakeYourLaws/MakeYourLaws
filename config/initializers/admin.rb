# via http://www.simple10.com/resque-admin-in-rails-3-routes-with-cancan/
class IsAdmin
  def self.matches?(request)
    current_user = request.env['warden'].user
    return false if current_user.blank?
    Ability.new(current_user).is_admin?
  end
end
