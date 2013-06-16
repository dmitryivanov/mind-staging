class HomeController < ApplicationController
  before_filter :authenticate_user!, :only =>[:dataload_list]
  
  def index
  end
  
  def dataload_list
    @dataload_manuals = current_user.dataload_manuals.order('created_at DESC').all
    @dataload_mailchimp = DataloadMailchimp.last
  end
end