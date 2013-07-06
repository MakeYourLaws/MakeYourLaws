require 'test_helper'

class CartWidgetTest < Apotomo::TestCase
  has_widgets do |root|
    root << widget(:cart)
  end
  
  test "display" do
    render_widget :cart
    assert_select "h1"
  end
end
