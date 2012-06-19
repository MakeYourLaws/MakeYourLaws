class Users::RegistrationsController < Devise::RegistrationsController
  def new_from_id
    if session["devise.identity"] and identity = Identity.find(session["devise.identity"])
      resource = build_resource({:email => identity.email, :name => identity.name,
                                  :login => identity.nickname})
      resource.identities << identity
      
      track! 'signup from id', :provider => identity.provider
      respond_with_navigational(resource){ render :new_from_id }
    else
      track! 'signup from id error'
      flash[:error] = "Something's wrong with your session. Please try again and ensure cookies are on."
      redirect_to signup_path
    end
  end
  
  def create
    build_resource

    if session["devise.identity"] and identity = Identity.find(session["devise.identity"])
      resource.identities << identity
    end
    
    if resource.save
      if resource.active_for_authentication?
        track! "signup completed"
        set_flash_message :notice, :signed_up if is_navigational_format?
        sign_in(resource_name, resource)
        respond_with resource, :location => after_sign_up_path_for(resource)
      else
        track! "signup pending", :issue => resource.inactive_message
        set_flash_message :notice, :"signed_up_but_#{resource.inactive_message}" if is_navigational_format?
        expire_session_data_after_sign_in!
        respond_with resource, :location => after_inactive_sign_up_path_for(resource)
      end
    else
      track! 'signup started'
      clean_up_passwords resource
      respond_with_navigational(resource) do
         if session["devise.identity"]
           render :new_from_id # capture any user info the provider didn't give & confirm the rest
         else
           render :new  # some validation error; show just-signup form to clear and complete
         end
       end
    end
  end
end