require 'rails_helper'

RSpec.describe "bit_pay_clients/edit", type: :view do
  before(:each) do
    @bit_pay_client = assign(:bit_pay_client, BitPayClient.create!(
      :api_uri => "MyString"
    ))
  end

  it "renders the edit bit_pay_client form" do
    render

    assert_select "form[action=?][method=?]", bit_pay_client_path(@bit_pay_client), "post" do

      assert_select "input#bit_pay_client_api_uri[name=?]", "bit_pay_client[api_uri]"
    end
  end
end
