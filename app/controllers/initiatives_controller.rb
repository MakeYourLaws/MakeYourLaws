class InitiativesController < ApplicationController
  load_and_authorize_resource
  
  def new
  end
  
  def create
    @initiative = Initiative.new params[:initiative]
    if @initiative.save
      redirect_to @initiative
    else
      flash[:error] = "Error saving initiative"
      render :new
    end
  end
  
  def show
  end
  
  def index
  end
  
  def search
  end
  
  def destroy
  end
  
  def edit
  end
  
  def update
  end
end
