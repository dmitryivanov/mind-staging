require 'test_helper'

class DataloadMailchimpsControllerTest < ActionController::TestCase
  setup do
    @dataload_mailchimp = dataload_mailchimps(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:dataload_mailchimps)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create dataload_mailchimp" do
    assert_difference('DataloadMailchimp.count') do
      post :create, dataload_mailchimp: { /: @dataload_mailchimp./, campaigns: @dataload_mailchimp.campaigns, file_name: @dataload_mailchimp.file_name, mc_password: @dataload_mailchimp.mc_password, mc_username: @dataload_mailchimp.mc_username, metrics: @dataload_mailchimp.metrics, request_user: @dataload_mailchimp.request_user, schedule: @dataload_mailchimp.schedule, success_ind: @dataload_mailchimp.success_ind, table_name: @dataload_mailchimp.table_name }
    end

    assert_redirected_to dataload_mailchimp_path(assigns(:dataload_mailchimp))
  end

  test "should show dataload_mailchimp" do
    get :show, id: @dataload_mailchimp
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @dataload_mailchimp
    assert_response :success
  end

  test "should update dataload_mailchimp" do
    put :update, id: @dataload_mailchimp, dataload_mailchimp: { /: @dataload_mailchimp./, campaigns: @dataload_mailchimp.campaigns, file_name: @dataload_mailchimp.file_name, mc_password: @dataload_mailchimp.mc_password, mc_username: @dataload_mailchimp.mc_username, metrics: @dataload_mailchimp.metrics, request_user: @dataload_mailchimp.request_user, schedule: @dataload_mailchimp.schedule, success_ind: @dataload_mailchimp.success_ind, table_name: @dataload_mailchimp.table_name }
    assert_redirected_to dataload_mailchimp_path(assigns(:dataload_mailchimp))
  end

  test "should destroy dataload_mailchimp" do
    assert_difference('DataloadMailchimp.count', -1) do
      delete :destroy, id: @dataload_mailchimp
    end

    assert_redirected_to dataload_mailchimps_path
  end
end
