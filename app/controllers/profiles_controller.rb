class ProfilesController < ApplicationController
  load_and_authorize_resource

  def show
    @profile = Profile.find(params[:id].is_a?(String) ? params[:id].downcase : params[:id].to_i)
  end

  def new
  end

  def create
    @profile = Profile.new( profile_params )
    @profile.type = 'recipient'
    if @profile.save
      current_user.has_role :admin, @profile
      redirect_to @profile
    else
      flash[:error] = 'Error saving profile'
      render :new
    end
  end

  def edit
  end

  def update
    # To delete avatar image:
    # @profile.avatar = nil
    # @profile.save
    if @profile.update_attributes profile_params
      redirect_to @profile
    else
      flash[:error] = 'Error saving profile'
      render :edit
    end
  end

  private

  def profile_params
    params.require(:profile).permit(:avatar, :handle, :name, :bio)
  end
end