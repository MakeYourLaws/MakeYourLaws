require 'test_helper'

class CartItemWidgetTest < Apotomo::TestCase
  has_widgets do |root|
    root << widget(:cart_item)
  end
  
  test "display" do
    render_widget :cart_item
    assert_select "h1"
  end
end
