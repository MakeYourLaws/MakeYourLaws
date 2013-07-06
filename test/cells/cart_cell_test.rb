require 'test_helper'

class CartCellTest < Cell::TestCase
  test "show" do
    invoke :show
    assert_select "p"
  end
  
  test "index" do
    invoke :index
    assert_select "p"
  end
  
  test "destroy" do
    invoke :destroy
    assert_select "p"
  end
  
  test "check_out" do
    invoke :check_out
    assert_select "p"
  end
  

end
