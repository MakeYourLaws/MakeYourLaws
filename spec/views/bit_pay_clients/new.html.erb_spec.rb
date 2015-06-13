require 'rails_helper'

RSpec.describe "bit_pay_clients/new", type: :view do
  before(:each) do
    assign(:bit_pay_client, BitPayClient.new(
      :api_uri => "MyString"
    ))
  end

  it "renders new bit_pay_client form" do
    render

    assert_select "form[action=?][method=?]", bit_pay_clients_path, "post" do

      assert_select "input#bit_pay_client_api_uri[name=?]", "bit_pay_client[api_uri]"
    end
  end
end
