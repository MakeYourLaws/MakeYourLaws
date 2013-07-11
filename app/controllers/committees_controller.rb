class CommitteesController < ApplicationController
  load_and_authorize_resource :class => "::Committee"
  
  def new
  end
  
  def create
    @committee = Committee.new params[:committee]
    if @committee.save
      redirect_to @committee
    else
      flash[:error] = "Error saving committee"
      render :new
    end
  end
  
  def show
  end
  
  def index
  end
  
  # def search
  # end
  # 
  # def destroy
  # end
  
  def edit
  end
  
  def update
    if @committee.update_attributes params[:committee]
      redirect_to @committee
    else
      flash[:error] = "Error saving committee"
      render :edit
    end
  end
  
  private
  
  def committee_params
    params.require(:committee).permit(:jurisdiction, :legal_id, :acronym, :short_name, :full_name, 
      :type, :foreign_contributions_okay, :corporation_full_name, :corporation_acronym, :corporation_type, 
      :corporation_ein, :contact_name, :contact_title, :email, :phone, :url, :party, :address, 
      :paypal_email, :notes)
  end
  
end
