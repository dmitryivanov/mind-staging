class DataloadGasController < ApplicationController
  # GET /dataload_gas
  # GET /dataload_gas.json
  def index
    @dataload_gas = DataloadGa.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @dataload_gas }
    end
  end

  # GET /dataload_gas/1
  # GET /dataload_gas/1.json
  def show
    @dataload_ga = DataloadGa.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @dataload_ga }
    end
  end

  # GET /dataload_gas/new
  # GET /dataload_gas/new.json
  def new
    @dataload_ga = DataloadGa.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @dataload_ga }
    end
  end

  # GET /dataload_gas/1/edit
  def edit
    @dataload_ga = DataloadGa.find(params[:id])
    # unless @dataload_ga.ga_credentials_valid?
    #   flash.now[:error] = 'Error. Google Analytics credentials are not valid'
    # end
      
     # NEXT: 
     #  * guard shouldnt run integration tests
     #  * guard shoulndt rerun all tests (after decorators)
     # 
     #  * add tests for decorator
     #  * add js to show and submit proper profile id
     #  * add jasmine test for that
     #
     #  * Metrics and dimensions selector
     #  * frequency
     #  * create/delete table for saving dataload results
     #  * add a checkbox for 'truncate table first' option
     
     #  * guard + foreman
  end

  # POST /dataload_gas
  # POST /dataload_gas.json
  def create
    @dataload_ga = DataloadGa.new(params[:dataload_ga])

    respond_to do |format|
      if @dataload_ga.save
        format.html { redirect_to edit_dataload_ga_path(@dataload_ga), notice: 'Dataload ga was successfully created.' }
        format.json { render json: @dataload_ga, status: :created, location: @dataload_ga }
      else
        format.html { render action: "new" }
        format.json { render json: @dataload_ga.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /dataload_gas/1
  # PUT /dataload_gas/1.json
  def update
    unless params[:commit] == 'Next'
      redirect_to edit_dataload_ga_path(params[:id])
      return
    end
    
    @dataload_ga = DataloadGa.find(params[:id])
    @dataload_ga.assign_attributes(params[:dataload_ga])

    if @dataload_ga.next_step
      flash.now[:notice] ='Dataload ga was successfully updated.'
    else
      flash.now[:alert] = 'Dataload ga was not updated.'
    end
    
    render :edit
  end

  # DELETE /dataload_gas/1
  # DELETE /dataload_gas/1.json
  def destroy
    @dataload_ga = DataloadGa.find(params[:id])
    @dataload_ga.destroy

    respond_to do |format|
      format.html { redirect_to dataload_gas_url }
      format.json { head :no_content }
    end
  end
end
