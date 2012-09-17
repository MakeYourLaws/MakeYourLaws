class ApplicationController < ActionController::Base
  # TODO: restore once ExceptionLogger is 3.1 compatible
  # include ExceptionLogger::ExceptionLoggable
  # rescue_from Exception, :with => :log_exception_handler 
  
  protect_from_forgery
  include Mixpanel
  
  def info_for_paper_trail
    { :ip => request.remote_ip }
  end
  
  rescue_from CanCan::AccessDenied do |exception|
    Rails.logger.debug "Access denied on #{exception.action} #{exception.subject.inspect}"
    redirect_to root_url, :alert => exception.message
  end
  
  before_filter :security_headers
  before_filter :cleanup

  private
  
  # Note: Strict-Transport-Security is already set to 1 year through config.force_ssl (i.e. Rack:SSL)
  def security_headers
    response.headers['X-Frame-Options'] = 'SAMEORIGIN'
    response.headers['X-XSS-Protection'] = '1; mode=block'
  end
  
  def cleanup
    flash[:timedout] = nil # added by Devise, redundant
  end
end
