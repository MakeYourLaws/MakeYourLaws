class CommitteesController < ApplicationController
  load_and_authorize_resource class: '::Committee'

  def new
    @committee = Committee.new
    authorize! :create, @committee
  end

  def create
# debugger
    @committee = Committee.new committee_params
    authorize! :create, @committee

    if @committee.save
      redirect_to @committee
    else
      flash[:error] = 'Error saving committee'
      render :new
    end
  end

  def show
    @committee = Committee.find params[:id]
    authorize! :show, @committee
  end

  def index
    authorize! :read, Committee
    @committees = Committee.all # FIXME: paginate
  end

  # def search
  # end
  #
  # def destroy
  # end

  def edit
    @committee = Committee.find params[:id]
    authorize! :update, @committee
  end

  def update
    @committee = Committee.find params[:id]
    authorize! :update, @committee

    if @committee.update_attributes committee_params
      redirect_to @committee
    else
      flash[:error] = 'Error saving committee'
      render :edit
    end
  end

  private

  def committee_params
    params.require(:committee).permit(:jurisdiction, :legal_id, :acronym, :short_name, :full_name,
                                      :type, :foreign_contributions_okay, :corporation_full_name,
                                      :corporation_acronym, :corporation_type, :corporation_ein,
                                      :contact_name, :contact_title, :email, :phone, :url, :party,
                                      :address, :paypal_email, :notes)
  end
end
