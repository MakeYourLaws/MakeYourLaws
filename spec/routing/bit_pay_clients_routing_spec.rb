require "rails_helper"

RSpec.describe BitPayClientsController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/bit_pay_clients").to route_to("bit_pay_clients#index")
    end

    it "routes to #new" do
      expect(:get => "/bit_pay_clients/new").to route_to("bit_pay_clients#new")
    end

    it "routes to #show" do
      expect(:get => "/bit_pay_clients/1").to route_to("bit_pay_clients#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/bit_pay_clients/1/edit").to route_to("bit_pay_clients#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/bit_pay_clients").to route_to("bit_pay_clients#create")
    end

    it "routes to #update" do
      expect(:put => "/bit_pay_clients/1").to route_to("bit_pay_clients#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/bit_pay_clients/1").to route_to("bit_pay_clients#destroy", :id => "1")
    end

  end
end
