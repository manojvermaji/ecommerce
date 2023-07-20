require "test_helper"

class CartItemControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get cart_item_index_url
    assert_response :success
  end
end
