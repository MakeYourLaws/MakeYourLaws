class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def method_missing kind
    unless resource_class.omniauth_providers.include? kind
      flash[:error] = "#{kind} is not a supported identification method."
      redirect_to login_path and return
    end
    
    auth = request.env["omniauth.auth"] # 1. Get the Omniauth response
    
    unless id = Identity.by_omniauth(auth) # 2. Update or create an Identity to go with it
      flash[:error] = I18n.t "devise.omniauth_callbacks.failure", :kind => kind # TODO: add reason
      redirect_to login_path and return
    end
    
    if @user = id.user # 3a. Log them in if they're already a user
      flash[:notice] = I18n.t "devise.omniauth_callbacks.success", :kind => kind
      sign_in_and_redirect @user, :event => :authentication # or back to request.env["omniauth.origin"]
    else
      session["identity"] = id.id # 3b. Validate info & create user account
      redirect_to signup_from_id_path
    end
  end
end