require 'test_helper'

class DataloadEmailsControllerTest < ActionController::TestCase
  setup do
    @dataload_email = dataload_emails(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:dataload_emails)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create dataload_email" do
    assert_difference('DataloadEmail.count') do
      post :create, dataload_email: { /: @dataload_email./, attachment_name: @dataload_email.attachment_name, email_label: @dataload_email.email_label, email_password: @dataload_email.email_password, email_username: @dataload_email.email_username, file_name: @dataload_email.file_name, request_user: @dataload_email.request_user, s3_id: @dataload_email.s3_id, schedule: @dataload_email.schedule, success_ind: @dataload_email.success_ind, table_name: @dataload_email.table_name }
    end

    assert_redirected_to dataload_email_path(assigns(:dataload_email))
  end

  test "should show dataload_email" do
    get :show, id: @dataload_email
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @dataload_email
    assert_response :success
  end

  test "should update dataload_email" do
    put :update, id: @dataload_email, dataload_email: { /: @dataload_email./, attachment_name: @dataload_email.attachment_name, email_label: @dataload_email.email_label, email_password: @dataload_email.email_password, email_username: @dataload_email.email_username, file_name: @dataload_email.file_name, request_user: @dataload_email.request_user, s3_id: @dataload_email.s3_id, schedule: @dataload_email.schedule, success_ind: @dataload_email.success_ind, table_name: @dataload_email.table_name }
    assert_redirected_to dataload_email_path(assigns(:dataload_email))
  end

  test "should destroy dataload_email" do
    assert_difference('DataloadEmail.count', -1) do
      delete :destroy, id: @dataload_email
    end

    assert_redirected_to dataload_emails_path
  end
end
