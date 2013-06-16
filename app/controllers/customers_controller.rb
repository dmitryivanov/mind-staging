class CustomersController < ApplicationController
  # should restrict access to logged in visitors only
  before_filter :authenticate_user!
  
  # GET /customers
  # GET /customers.json
  def index
    if params[:search] 
        @customers = Customer.paginate(:page => params[:page], per_page: 10, :conditions => ["last_name LIKE ?", "%#{params[:search]}%"])
        if @customers.size.zero?
            flash[:notice] = "No results found"
        end
    else
        # @customers = @customers.paginate page: params[:page], per_page: 10
        @customers = Customer.paginate(:page => params[:page], per_page: 10) 
    end

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @customers }
    end
  end

#  def index
#    @customer = Customer.search(params[:search])
#  end
  
#  def index 
#    if params[:search] 
#        @projects = Project.find(:all, :conditions => ["name LIKE ?", "%#{params[:search]}%"]) 
#       if @projects.size.zero? 
#            flash[:notice] = "No result found" 
#            @projects = Project.find(:all) 
#        end 
#    else 
#        @projects = Project.find(:all) 
#    end 
#  end

  # GET /customers/1
  # GET /customers/1.json
  def show
    @customer = Customer.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @customer }
    end
  end

  # GET /customers/new
  # GET /customers/new.json
  def new
    @customer = Customer.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @customer }
    end
  end

  # GET /customers/1/edit
  def edit
    @customer = Customer.find(params[:id])
  end

  # POST /customers
  # POST /customers.json
  def create
    @customer = Customer.new(params[:customer])

    respond_to do |format|
      if @customer.save
        format.html { redirect_to @customer, notice: 'Customer was successfully created.' }
        format.json { render json: @customer, status: :created, location: @customer }
      else
        format.html { render action: "new" }
        format.json { render json: @customer.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /customers/1
  # PUT /customers/1.json
  def update
    @customer = Customer.find(params[:id])

    respond_to do |format|
      if @customer.update_attributes(params[:customer])
        format.html { redirect_to @customer, notice: 'Customer was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @customer.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /customers/1
  # DELETE /customers/1.json
  def destroy
    @customer = Customer.find(params[:id])
    @customer.destroy

    respond_to do |format|
      format.html { redirect_to customers_url }
      format.json { head :no_content }
    end
  end
  
end
