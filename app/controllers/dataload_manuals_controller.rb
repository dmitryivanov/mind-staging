class DataloadManualsController < ApplicationController
  # GET /dataload_manuals
  # GET /dataload_manuals.json
  def index
    @dataload_manuals = current_user.dataload_manuals

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @dataload_manuals }
    end
  end

  # GET /dataload_manuals/1
  # GET /dataload_manuals/1.json
  def show
    @dataload_manual = current_user.dataload_manuals.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @dataload_manual }
    end
  end

  # GET /dataload_manuals/new
  # GET /dataload_manuals/new.json
  def new
    @dataload_manual = current_user.dataload_manuals.build

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @dataload_manual }
    end
  end

  # GET /dataload_manuals/1/edit
  def edit
    @dataload_manual = current_user.dataload_manuals.find(params[:id])
  end

  # POST /dataload_manuals
  # POST /dataload_manuals.json
  def create
    @dataload_manual = current_user.dataload_manuals.build(params[:dataload_manual])

    respond_to do |format|
      if @dataload_manual.save
        @dataload_manual.perform_import
        format.html { redirect_to @dataload_manual, notice: 'Dataload manual was successfully created.' }
        format.json { render json: @dataload_manual, status: :created, location: @dataload_manual }
      else
        format.html { render action: "new" }
        format.json { render json: @dataload_manual.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /dataload_manuals/1
  # PUT /dataload_manuals/1.json
  def update
    @dataload_manual = current_user.dataload_manuals.find(params[:id])

    respond_to do |format|
      if @dataload_manual.update_attributes(params[:dataload_manual])
        format.html { redirect_to @dataload_manual, notice: 'Dataload manual was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @dataload_manual.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /dataload_manuals/1
  # DELETE /dataload_manuals/1.json
  def destroy
    @dataload_manual = current_user.dataload_manuals.find(params[:id])
    @dataload_manual.destroy

    respond_to do |format|
      format.html { redirect_to dataload_manuals_url }
      format.json { head :no_content }
    end
  end
end
