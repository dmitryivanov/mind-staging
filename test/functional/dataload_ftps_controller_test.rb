require 'test_helper'

class DataloadFtpsControllerTest < ActionController::TestCase
  setup do
    @dataload_ftp = dataload_ftps(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:dataload_ftps)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create dataload_ftp" do
    assert_difference('DataloadFtp.count') do
      post :create, dataload_ftp: { /: @dataload_ftp./, file_name: @dataload_ftp.file_name, ftp_directory: @dataload_ftp.ftp_directory, ftp_password: @dataload_ftp.ftp_password, ftp_url: @dataload_ftp.ftp_url, ftp_username: @dataload_ftp.ftp_username, request_user: @dataload_ftp.request_user, s3_id: @dataload_ftp.s3_id, schedule: @dataload_ftp.schedule, success_ind: @dataload_ftp.success_ind, table_name: @dataload_ftp.table_name }
    end

    assert_redirected_to dataload_ftp_path(assigns(:dataload_ftp))
  end

  test "should show dataload_ftp" do
    get :show, id: @dataload_ftp
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @dataload_ftp
    assert_response :success
  end

  test "should update dataload_ftp" do
    put :update, id: @dataload_ftp, dataload_ftp: { /: @dataload_ftp./, file_name: @dataload_ftp.file_name, ftp_directory: @dataload_ftp.ftp_directory, ftp_password: @dataload_ftp.ftp_password, ftp_url: @dataload_ftp.ftp_url, ftp_username: @dataload_ftp.ftp_username, request_user: @dataload_ftp.request_user, s3_id: @dataload_ftp.s3_id, schedule: @dataload_ftp.schedule, success_ind: @dataload_ftp.success_ind, table_name: @dataload_ftp.table_name }
    assert_redirected_to dataload_ftp_path(assigns(:dataload_ftp))
  end

  test "should destroy dataload_ftp" do
    assert_difference('DataloadFtp.count', -1) do
      delete :destroy, id: @dataload_ftp
    end

    assert_redirected_to dataload_ftps_path
  end
end
