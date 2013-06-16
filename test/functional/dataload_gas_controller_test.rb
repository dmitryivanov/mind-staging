require 'test_helper'

class DataloadGasControllerTest < ActionController::TestCase
  setup do
    @dataload_ga = dataload_gas(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:dataload_gas)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create dataload_ga" do
    assert_difference('DataloadGa.count') do
      post :create, dataload_ga: { /: @dataload_ga./, dimensions: @dataload_ga.dimensions, file_name: @dataload_ga.file_name, ga_password: @dataload_ga.ga_password, ga_username: @dataload_ga.ga_username, metrics: @dataload_ga.metrics, request_user: @dataload_ga.request_user, s3_id: @dataload_ga.s3_id, schedule: @dataload_ga.schedule, success_ind: @dataload_ga.success_ind, table_name: @dataload_ga.table_name }
    end

    assert_redirected_to dataload_ga_path(assigns(:dataload_ga))
  end

  test "should show dataload_ga" do
    get :show, id: @dataload_ga
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @dataload_ga
    assert_response :success
  end

  test "should update dataload_ga" do
    put :update, id: @dataload_ga, dataload_ga: { /: @dataload_ga./, dimensions: @dataload_ga.dimensions, file_name: @dataload_ga.file_name, ga_password: @dataload_ga.ga_password, ga_username: @dataload_ga.ga_username, metrics: @dataload_ga.metrics, request_user: @dataload_ga.request_user, s3_id: @dataload_ga.s3_id, schedule: @dataload_ga.schedule, success_ind: @dataload_ga.success_ind, table_name: @dataload_ga.table_name }
    assert_redirected_to dataload_ga_path(assigns(:dataload_ga))
  end

  test "should destroy dataload_ga" do
    assert_difference('DataloadGa.count', -1) do
      delete :destroy, id: @dataload_ga
    end

    assert_redirected_to dataload_gas_path
  end
end
