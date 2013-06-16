class StatusRptsController < ApplicationController
  # GET /status_rpts
  # GET /status_rpts.json
  
  before_filter :authenticate_user!
 
  def index
    @status_rpts = StatusRpt.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @status_rpts }
    end
  end

  # GET /status_rpts/1
  # GET /status_rpts/1.json
  def show
    @status_rpt = StatusRpt.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @status_rpt }
    end
  end

  # GET /status_rpts/new
  # GET /status_rpts/new.json
  def new
    @status_rpt = StatusRpt.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @status_rpt }
    end
  end

  # GET /status_rpts/1/edit
  def edit
    @status_rpt = StatusRpt.find(params[:id])
  end

  # POST /status_rpts
  # POST /status_rpts.json
  def create
    @status_rpt = StatusRpt.new(params[:status_rpt])

    respond_to do |format|
      if @status_rpt.save
        format.html { redirect_to @status_rpt, notice: 'Status rpt was successfully created.' }
        format.json { render json: @status_rpt, status: :created, location: @status_rpt }
      else
        format.html { render action: "new" }
        format.json { render json: @status_rpt.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /status_rpts/1
  # PUT /status_rpts/1.json
  def update
    @status_rpt = StatusRpt.find(params[:id])

    respond_to do |format|
      if @status_rpt.update_attributes(params[:status_rpt])
        format.html { redirect_to @status_rpt, notice: 'Status rpt was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @status_rpt.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /status_rpts/1
  # DELETE /status_rpts/1.json
  def destroy
    @status_rpt = StatusRpt.find(params[:id])
    @status_rpt.destroy

    respond_to do |format|
      format.html { redirect_to status_rpts_url }
      format.json { head :no_content }
    end
  end
end
