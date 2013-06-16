class DashboardsController < ApplicationController
  # GET /dashboards
  # GET /dashboards.json

  before_filter :authenticate_user!

  def index
    @dashboards = Dashboard.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @dashboards }
    end
  end

  # GET /dashboards/1
  # GET /dashboards/1.json
  def show
    @dashboard = Dashboard.find(params[:id])
    @chart_selectors_data = {}
    
    tables = []   
    (ActiveRecord::RdsDb.connection.tables - ['schema_migrations']).each do |table_name|
      next unless ar_class_exist?(table_name)
      
      table = {
        name: table_name.titleize,
        value: table_name,
        dimensions: [],
        metrics: [],
        dates: []
      }
      
      table_class = table_name.classify.constantize
      table_class.columns.each do |column|
        next unless [:string, :integer, :datetime].include?(column.type)
        
        # TODO: Dimension can be either string field or belongs_to association
        
        if [:string, :integer].include?(column.type)
          table[:dimensions] << prepare_column(column)
          table[:metrics] << prepare_column(column) 
        elsif column.type == :datetime
          table[:dates] << prepare_column(column)
        end
          
      end 
      
      tables << table    
    end
    
    
    
    @chart_selectors_data[:tables] = tables
    @dashboard_modules = @dashboard.dashboard_modules.order('created_at DESC')

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @dashboard }
    end
  end

  # GET /dashboards/new
  # GET /dashboards/new.json
  def new
    @dashboard = Dashboard.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @dashboard }
    end
  end

  # GET /dashboards/1/edit
  def edit
    @dashboard = Dashboard.find(params[:id])
  end

  # POST /dashboards
  # POST /dashboards.json
  def create
    @dashboard = Dashboard.new(params[:dashboard])

    respond_to do |format|
      if @dashboard.save
        format.html { redirect_to @dashboard, notice: 'Dashboard was successfully created.' }
        format.json { render json: @dashboard, status: :created, location: @dashboard }
      else
        format.html { render action: "new" }
        format.json { render json: @dashboard.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /dashboards/1
  # PUT /dashboards/1.json
  def update
    @dashboard = Dashboard.find(params[:id])

    respond_to do |format|
      if @dashboard.update_attributes(params[:dashboard])
        format.html { redirect_to @dashboard, notice: 'Dashboard was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @dashboard.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /dashboards/1
  # DELETE /dashboards/1.json
  def destroy
    @dashboard = Dashboard.find(params[:id])
    @dashboard.destroy

    respond_to do |format|
      format.html { redirect_to dashboards_url }
      format.json { head :no_content }
    end
  end
  
private
  
  def prepare_column(column)
    values = {}
    values[:name] = column.name.titleize
    values[:value] = column.name
    
    return values
  end
  
  def ar_class_exist?(class_name)
    begin
      class_name.classify.constantize
      true
    rescue NameError
      false
    end
  end
  
end
