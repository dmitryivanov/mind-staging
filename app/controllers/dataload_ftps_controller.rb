class DataloadFtpsController < ApplicationController
  # GET /dataload_ftps
  # GET /dataload_ftps.json
  def index
    @dataload_ftps = DataloadFtp.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @dataload_ftps }
    end
  end

  # GET /dataload_ftps/1
  # GET /dataload_ftps/1.json
  def show
    @dataload_ftp = DataloadFtp.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @dataload_ftp }
    end
  end

  # GET /dataload_ftps/new
  # GET /dataload_ftps/new.json
  def new
    @dataload_ftp = DataloadFtp.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @dataload_ftp }
    end
  end

  # GET /dataload_ftps/1/edit
  def edit
    @dataload_ftp = DataloadFtp.find(params[:id])
  end

  # POST /dataload_ftps
  # POST /dataload_ftps.json
  def create
    @dataload_ftp = DataloadFtp.new(params[:dataload_ftp])

    respond_to do |format|
      if @dataload_ftp.save
        format.html { redirect_to @dataload_ftp, notice: 'Dataload ftp was successfully created.' }
        format.json { render json: @dataload_ftp, status: :created, location: @dataload_ftp }
      else
        format.html { render action: "new" }
        format.json { render json: @dataload_ftp.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /dataload_ftps/1
  # PUT /dataload_ftps/1.json
  def update
    @dataload_ftp = DataloadFtp.find(params[:id])

    respond_to do |format|
      if @dataload_ftp.update_attributes(params[:dataload_ftp])
        format.html { redirect_to @dataload_ftp, notice: 'Dataload ftp was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @dataload_ftp.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /dataload_ftps/1
  # DELETE /dataload_ftps/1.json
  def destroy
    @dataload_ftp = DataloadFtp.find(params[:id])
    @dataload_ftp.destroy

    respond_to do |format|
      format.html { redirect_to dataload_ftps_url }
      format.json { head :no_content }
    end
  end
end
