require 'test_helper'

class CustomerControllerTest < ActionController::TestCase
  test "should get add" do
    get :add
    assert_response :success
  end

  test "should get view" do
    get :view
    assert_response :success
  end

end
