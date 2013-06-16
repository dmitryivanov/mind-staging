require 'test_helper'

class StatusRptsControllerTest < ActionController::TestCase
  setup do
    @status_rpt = status_rpts(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:status_rpts)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create status_rpt" do
    assert_difference('StatusRpt.count') do
      post :create, status_rpt: @status_rpt.attributes
    end

    assert_redirected_to status_rpt_path(assigns(:status_rpt))
  end

  test "should show status_rpt" do
    get :show, id: @status_rpt
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @status_rpt
    assert_response :success
  end

  test "should update status_rpt" do
    put :update, id: @status_rpt, status_rpt: @status_rpt.attributes
    assert_redirected_to status_rpt_path(assigns(:status_rpt))
  end

  test "should destroy status_rpt" do
    assert_difference('StatusRpt.count', -1) do
      delete :destroy, id: @status_rpt
    end

    assert_redirected_to status_rpts_path
  end
end
