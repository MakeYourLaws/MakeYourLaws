class AgreementsController < ApplicationController
  ensure_current_user

  # GET /role_agreements/:role_name
  def for_role
    @role = Role.find_by_name!(params[:role_name])
    ensure_offered_role(params[:role_name])
    users_role = UsersRole.where(:user_id => current_user.id, :role_id => @role.id).first!
    @needed_agreements = users_role.needed_agreements
    if @needed_agreements.empty?
      flash[:notice] = flash.now[:notice] = "all agreed for #{@role.name}" # TODO words
      redirect_to(session[:return_after_agreed] || root_url)
    end
  end

  # POST /agreements/:name/:version/agree
  def agree
    agreement = Agreement.where(params.permit(:name, :version)).first!
    current_user.users_agreements.create!(:agreement_id => agreement.id)
    flash[:notice] = flash.now[:notice] = "thanks for agreeing to #{agreement.name} #{agreement.version}"
    if params[:for_role_name]
      redirect_to :action => :for_role, :role_name => params[:for_role_name]
    else
      redirect_to(session[:return_after_agreed] || root_url)
    end
  end
end
