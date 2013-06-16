require 'test_helper'

class CustomerWarrantyFileControllerTest < ActionController::TestCase
  test "should get file:string" do
    get :file:string
    assert_response :success
  end

end
