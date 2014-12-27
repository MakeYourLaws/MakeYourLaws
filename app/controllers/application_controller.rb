class ApplicationController < ActionController::Base
  # TODO: restore once ExceptionLogger is 3.1 compatible
  # include ExceptionLogger::ExceptionLoggable
  # rescue_from Exception, :with => :log_exception_handler

  before_action :configure_permitted_parameters, if: :devise_controller?

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  include Mixpanel

  def info_for_paper_trail
    { ip: request.remote_ip }
  end

  rescue_from CanCan::AccessDenied do |exception|
    Rails.logger.debug "Access denied on #{exception.action} #{exception.subject.inspect}"
    redirect_to root_url, alert: exception.message
  end

  def self.ensure_role(*role_names)
    before_action { ensure_role(*role_names) }
  end

  def self.ensure_agreed(*agreement_names)
    before_action { ensure_agreed(*agreement_names) }
  end

  def redirect_back_or_root
    if request.env['HTTP_REFERER'].present?
      redirect_to :back
    else
      redirect_to root_url
    end
  end

  def self.ensure_current_user
    before_action { ensure_current_user }
  end

  def ensure_current_user
    unless current_user
      flash[:error] = "You must be logged in to do that"
      redirect_back_or_root
      return false
    end
    nil
  end

  def ensure_offered_role(*role_names)
    not_offered = role_names.reject { |role_name| current_user ? current_user.offered_roles.any? { |role| role.name == role_name.to_s } : false }
    if not_offered.any?
      flash[:error] = "You are not authorized for that"
      redirect_back_or_root
      return false
    end
    nil
  end
  def ensure_role(*role_names)
    offered = ensure_offered_role(*role_names)
    return offered if offered == false
    not_active = role_names.reject { |role_name| current_user ? current_user.roles.any? { |role| role.name == role_name.to_s } : false }
    if not_active.any?
      session[:return_after_agreed] = request.url if request.get?
      flash[:notice] = "Please agree for role #{not_active.first}"
      redirect_to url_for(:controller => :agreements, :action => :for_role, :role_name => not_active.first)
      return false
    end
    nil
  end

  def ensure_agreed(*agreement_names)
    not_active = agreement_names.reject do |agreement_name|
      current_user ? current_user.active_agreements.where('agreements.name' => agreement_name.to_s).any? : false
    end
    if not_active.any?
      session[:return_after_agreed] = request.url if request.get?
      flash[:notice] = "please agree to agreement #{not_active.first}"
      redirect_to url_for(:controller => :agreements, :action => :show, :name => not_active.first)
      return false
    end
    nil
  end

  before_action :log_additional_data
  before_action :security_headers
  before_action :cleanup

  # incompatible w/ rails 4.
  #
  # include Apotomo::Rails::ControllerMethods
  # has_widgets do |root|
  #   root << widget(:cart, :user => current_user)
  #   root << widget(:cart_item, :user => current_user)
  # end

  force_ssl if: :ssl_configured?

  def hidden_service?
    request.env['HTTP_HOST'] =~ /\.onion\z/
  end
  helper_method :hidden_service?

  def tor?
    request.env['tor']
  end
  helper_method :tor?

  def admin?
    current_user && (current_user.id == 1)
  end
  helper_method :admin?

  def deny_tor_users
    redirect_to root_path, alert: 'Tor users may not use that functionality.' if tor?
  end

  private

  def ssl_configured?
    Rails.env.production? && !tor?
  end

  # Note: Strict-Transport-Security is already set to 1 year through config.force_ssl (i.e. Rack:SSL)
  def security_headers
    response.headers['X-Frame-Options'] = 'SAMEORIGIN'
    response.headers['X-XSS-Protection'] = '1; mode=block'
  end

  def cleanup
    flash[:timedout] = nil # added by Devise, redundant
  end

  protected

  def log_additional_data
    request.env['exception_notifier.exception_data'] = {
      user: current_user
    }
  end

  def configure_permitted_parameters
    # Defaults (see https://github.com/plataformatec/devise/tree/rails4):
    # sign_in (Devise::SessionsController#new) - Permits only the authentication keys (like email)
    # sign_up (Devise::RegistrationsController#create) - Permits authentication keys plus password
    #  and password_confirmation
    # account_update (Devise::RegistrationsController#update) - Permits authentication keys plus
    #  password, password_confirmation and current_password

    # Formerly, in Rails 3
    # attr_accessible :email, :password, :password_confirmation, :remember_me, :name, :login,
    #  :login_or_email

    # Modify them:
    # devise_parameter_sanitizer.for(:sign_in) { |u| u.permit(:login_or_email) }
    devise_parameter_sanitizer.for(:sign_up) do |u|
      u.permit(:email, :name, :password, :password_confirmation) # :login
    end
  end
end
