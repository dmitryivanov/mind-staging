class DashboardModulesController < ApplicationController
  respond_to :json
  include DashboardModuleMethods
  
  def create
    @dashboard = Dashboard.find(params[:dashboard_id])
    @module = @dashboard.dashboard_modules.create(params[:dashboard_module])
    respond_with @dashboard, @module
  end
  
  def update
    @dashboard = Dashboard.find(params[:dashboard_id])
    @module = @dashboard.dashboard_modules.find(params[:id])
    if @module.update_attributes(params[:dashboard_module])
      render :json => @module.to_json
    else
      render :json => { :errors => @module.errors.full_messages }, :status => 422
    end
  end
  
  def destroy
    @dashboard = Dashboard.find(params[:dashboard_id])
    respond_with @dashboard.dashboard_modules.find(params[:id]).destroy
  end
  
  def dimension_values
    table_class = params[:table].classify.constantize
    
    values = table_class.group(params[:dimension]).map do |d| 
      value = d.send(params[:dimension])
      name = dimension_value_association_name(table_class, params[:dimension], value)
      
      { name: name, value: value }
    end
    
    render :json => values
  end
end
