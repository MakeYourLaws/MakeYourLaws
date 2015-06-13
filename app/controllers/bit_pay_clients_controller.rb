class BitPayClientsController < ApplicationController
  before_action :set_bit_pay_client, only: [:show, :edit, :update, :destroy]

  # GET /bit_pay_clients
  # GET /bit_pay_clients.json
  def index
    @bit_pay_clients = BitPayClient.all
  end

  # GET /bit_pay_clients/1
  # GET /bit_pay_clients/1.json
  def show
  end

  # GET /bit_pay_clients/new
  def new
    @bit_pay_client = BitPayClient.new
  end

  # GET /bit_pay_clients/1/edit
  def edit
  end

  # POST /bit_pay_clients
  # POST /bit_pay_clients.json
  def create
    @bit_pay_client = BitPayClient.new(bit_pay_client_params)

    respond_to do |format|
      if @bit_pay_client.save
        format.html { redirect_to @bit_pay_client, notice: 'Bit pay client was successfully created.' }
        format.json { render :show, status: :created, location: @bit_pay_client }
      else
        format.html { render :new }
        format.json { render json: @bit_pay_client.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /bit_pay_clients/1
  # PATCH/PUT /bit_pay_clients/1.json
  def update
    respond_to do |format|
      if @bit_pay_client.update(bit_pay_client_params)
        format.html { redirect_to @bit_pay_client, notice: 'Bit pay client was successfully updated.' }
        format.json { render :show, status: :ok, location: @bit_pay_client }
      else
        format.html { render :edit }
        format.json { render json: @bit_pay_client.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /bit_pay_clients/1
  # DELETE /bit_pay_clients/1.json
  def destroy
    @bit_pay_client.destroy
    respond_to do |format|
      format.html { redirect_to bit_pay_clients_url, notice: 'Bit pay client was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_bit_pay_client
      @bit_pay_client = BitPayClient.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def bit_pay_client_params
      params.require(:bit_pay_client).permit(:api_uri)
    end
end
