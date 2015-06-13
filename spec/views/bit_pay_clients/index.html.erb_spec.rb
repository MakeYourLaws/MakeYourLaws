require 'rails_helper'

RSpec.describe "bit_pay_clients/index", type: :view do
  before(:each) do
    assign(:bit_pay_clients, [
      BitPayClient.create!(
        :api_uri => "Api Uri"
      ),
      BitPayClient.create!(
        :api_uri => "Api Uri"
      )
    ])
  end

  it "renders a list of bit_pay_clients" do
    render
    assert_select "tr>td", :text => "Api Uri".to_s, :count => 2
  end
end
