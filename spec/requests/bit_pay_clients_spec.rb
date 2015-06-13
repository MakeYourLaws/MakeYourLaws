require 'rails_helper'

RSpec.describe "BitPayClients", type: :request do
  describe "GET /bit_pay_clients" do
    it "works! (now write some real specs)" do
      get bit_pay_clients_path
      expect(response).to have_http_status(200)
    end
  end
end
