class ApplicationController < ActionController::Base
  # TODO: restore once ExceptionLogger is 3.1 compatible
  # include ExceptionLogger::ExceptionLoggable
  # rescue_from Exception, :with => :log_exception_handler 
  
  before_filter :down_for_maintenance?
  def down_for_maintenance?
    path = "#{Rails.public_path}/maintenance.html"
    if (File.exist?(File.join(Rails.root, "tmp", "down")) and File.exist?(path) and
      (params[:s] != Keys.get("maintenance_code")))
      render :file => path, :status => 503, :content_type => Mime::HTML
    end
  end
  
  before_filter :configure_permitted_parameters, if: :devise_controller?

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  
  include Mixpanel
  
  def info_for_paper_trail
    { :ip => request.remote_ip }
  end
  
  rescue_from CanCan::AccessDenied do |exception|
    Rails.logger.debug "Access denied on #{exception.action} #{exception.subject.inspect}"
    redirect_to root_url, :alert => exception.message
  end
  
  before_filter :log_additional_data
  before_filter :security_headers
  before_filter :cleanup

  # incompatible w/ rails 4.
  # 
  # include Apotomo::Rails::ControllerMethods
  # has_widgets do |root|
  #   root << widget(:cart, :user => current_user)
  #   root << widget(:cart_item, :user => current_user)
  # end
  
  force_ssl if: :ssl_configured?
  
  def tor?
    request.host =~ /onion$/
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
    Rails.env.production? and !tor?
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
    request.env["exception_notifier.exception_data"] = {
      :user => current_user
    }
  end

  def configure_permitted_parameters
    # Defaults (see https://github.com/plataformatec/devise/tree/rails4):
    # sign_in (Devise::SessionsController#new) - Permits only the authentication keys (like email)
    # sign_up (Devise::RegistrationsController#create) - Permits authentication keys plus password and password_confirmation
    # account_update (Devise::RegistrationsController#update) - Permits authentication keys plus password, password_confirmation and current_password
    
    # Formerly, in Rails 3
    # attr_accessible :email, :password, :password_confirmation, :remember_me, :name, :login, :login_or_email
    
    # Modify them:
    # devise_parameter_sanitizer.for(:sign_in) { |u| u.permit(:login_or_email) }
    devise_parameter_sanitizer.for(:sign_up) { |u| u.permit(:email, :login, :name, :password, :password_confirmation) }
  end
end
