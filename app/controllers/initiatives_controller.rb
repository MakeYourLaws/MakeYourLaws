class InitiativesController < ApplicationController
  load_and_authorize_resource

  def new
  end

  def create
    @initiative = Initiative.new initiative_params
    if @initiative.save
      redirect_to @initiative
    else
      flash[:error] = 'Error saving initiative'
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
    if @initiative.update_attributes initiative_params
      redirect_to @initiative
    else
      flash[:error] = 'Error saving initiative'
      render :edit
    end
  end

  private

  def initiative_params
    params.require(:initiative).permit(:jurisdiction, :election_date, :filing_date, :summary_date,
                                       :circulation_deadline, :full_check_deadline, :election_type,
                                       :initiator_type, :initiative_type, :indirect,
                                       :initiative_name, :proposition_name, :title,
                                       :informal_title, :short_summary, :summary, :analysis, :text,
                                       :wikipedia_url, :ballotpedia_url) # but not status
  end
end
