class DataloadLogsController < ApplicationController
  before_filter :authenticate_user!
 
  def index
    @dataload_logs = DataloadLog.order('created_at DESC').page(params[:page])
  end
end
