# via http://www.simple10.com/resque-admin-in-rails-3-routes-with-cancan/
class CanAccessResque
  def self.matches?(request)
    current_user = request.env['warden'].user
    return false if current_user.blank?
    Ability.new(current_user).can? :manage, Resque
  end
end
