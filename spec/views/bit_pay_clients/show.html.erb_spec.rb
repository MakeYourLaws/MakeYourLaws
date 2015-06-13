require 'rails_helper'

RSpec.describe "bit_pay_clients/show", type: :view do
  before(:each) do
    @bit_pay_client = assign(:bit_pay_client, BitPayClient.create!(
      :api_uri => "Api Uri"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Api Uri/)
  end
end
