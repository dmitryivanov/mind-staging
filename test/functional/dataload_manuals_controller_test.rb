require 'test_helper'

class DataloadManualsControllerTest < ActionController::TestCase
  setup do
    @dataload_manual = dataload_manuals(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:dataload_manuals)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create dataload_manual" do
    assert_difference('DataloadManual.count') do
      post :create, dataload_manual: { /: @dataload_manual./, file_name: @dataload_manual.file_name, request_user: @dataload_manual.request_user, s3_id: @dataload_manual.s3_id, success_ind: @dataload_manual.success_ind, table_name: @dataload_manual.table_name }
    end

    assert_redirected_to dataload_manual_path(assigns(:dataload_manual))
  end

  test "should show dataload_manual" do
    get :show, id: @dataload_manual
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @dataload_manual
    assert_response :success
  end

  test "should update dataload_manual" do
    put :update, id: @dataload_manual, dataload_manual: { /: @dataload_manual./, file_name: @dataload_manual.file_name, request_user: @dataload_manual.request_user, s3_id: @dataload_manual.s3_id, success_ind: @dataload_manual.success_ind, table_name: @dataload_manual.table_name }
    assert_redirected_to dataload_manual_path(assigns(:dataload_manual))
  end

  test "should destroy dataload_manual" do
    assert_difference('DataloadManual.count', -1) do
      delete :destroy, id: @dataload_manual
    end

    assert_redirected_to dataload_manuals_path
  end
end
