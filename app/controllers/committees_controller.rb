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
    # attr_protected :id, :created_at, :fec_id
    params.require(:committee)
  end
  
end
