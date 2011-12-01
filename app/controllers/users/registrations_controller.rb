class Users::RegistrationsController < Devise::RegistrationsController
  def new_from_id
    if session["devise.identity"] and identity = Identity.find(session["devise.identity"])
      resource = build_resource({:email => identity.email, :name => identity.name,
                                  :login => identity.nickname})
      resource.identities << identity
      respond_with_navigational(resource){ render_with_scope :new_from_id }
    else
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
         set_flash_message :notice, :signed_up if is_navigational_format?
         sign_in(resource_name, resource)
         respond_with resource, :location => after_sign_up_path_for(resource)
       else
         set_flash_message :notice, :inactive_signed_up, :reason => inactive_reason(resource) if is_navigational_format?
         expire_session_data_after_sign_in!
         respond_with resource, :location => after_inactive_sign_up_path_for(resource)
       end
     else
       clean_up_passwords(resource)
       respond_with_navigational(resource) do
          if session["devise.identity"]
            render_with_scope :new_from_id
          else
            render_with_scope :new 
          end
        end
     end
   end
   
end