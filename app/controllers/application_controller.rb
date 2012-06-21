class ApplicationController < ActionController::Base
  # TODO: restore once ExceptionLogger is 3.1 compatible
  # include ExceptionLogger::ExceptionLoggable
  # rescue_from Exception, :with => :log_exception_handler 
  
  protect_from_forgery
  include Mixpanel
  
  
  before_filter :security_headers

  private
  
  # Note: Strict-Transport-Security is already set to 1 year through config.force_ssl (i.e. Rack:SSL)
  def security_headers
    response.headers['X-Frame-Options'] = 'SAMEORIGIN'
    response.headers['X-XSS-Protection'] = '1; mode=block'
  end
end
