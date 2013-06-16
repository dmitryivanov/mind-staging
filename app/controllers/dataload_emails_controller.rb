class DataloadEmailsController < ApplicationController
  # GET /dataload_emails
  # GET /dataload_emails.json
  def index
    @dataload_emails = DataloadEmail.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @dataload_emails }
    end
  end

  # GET /dataload_emails/1
  # GET /dataload_emails/1.json
  def show
    @dataload_email = DataloadEmail.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @dataload_email }
    end
  end

  # GET /dataload_emails/new
  # GET /dataload_emails/new.json
  def new
    @dataload_email = DataloadEmail.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @dataload_email }
    end
  end

  # GET /dataload_emails/1/edit
  def edit
    @dataload_email = DataloadEmail.find(params[:id])
  end

  # POST /dataload_emails
  # POST /dataload_emails.json
  def create
    @dataload_email = DataloadEmail.new(params[:dataload_email])

    respond_to do |format|
      if @dataload_email.save
        format.html { redirect_to @dataload_email, notice: 'Dataload email was successfully created.' }
        format.json { render json: @dataload_email, status: :created, location: @dataload_email }
      else
        format.html { render action: "new" }
        format.json { render json: @dataload_email.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /dataload_emails/1
  # PUT /dataload_emails/1.json
  def update
    @dataload_email = DataloadEmail.find(params[:id])

    respond_to do |format|
      if @dataload_email.update_attributes(params[:dataload_email])
        format.html { redirect_to @dataload_email, notice: 'Dataload email was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @dataload_email.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /dataload_emails/1
  # DELETE /dataload_emails/1.json
  def destroy
    @dataload_email = DataloadEmail.find(params[:id])
    @dataload_email.destroy

    respond_to do |format|
      format.html { redirect_to dataload_emails_url }
      format.json { head :no_content }
    end
  end
end
