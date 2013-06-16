class ApplicationController < ActionController::Base
  include UrlHelper
  protect_from_forgery
  
  set_current_tenant_through_filter
  before_filter :set_current_account
  
  def set_current_account
    if user_signed_in?
      current_account = Account.find(current_user.account_id)
      set_current_tenant(current_account)
    else
      set_current_tenant(nil)
    end  
  end

  def after_sign_in_path_for(resource)
    dashboards_url(:subdomain =>  ActsAsTenant.current_tenant.domain)    
  end
  
  def after_sign_out_path_for(resource)
    "http://mind-dev.com:3000"
  end

end
