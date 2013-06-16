class DataloadMailchimpsController < ApplicationController

  # GET /dataload_mailchimps/1
  # GET /dataload_mailchimps/1.json
  def show
    redirect_to edit_dataload_mailchimp_path
  end

  # GET /dataload_mailchimps/new
  # GET /dataload_mailchimps/new.json
  def new
    @dataload = DataloadMailchimp.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @dataload }
    end
  end

  # GET /dataload_mailchimps/1/edit
  def edit
    @dataload = DataloadMailchimp.first
    unless @dataload
      redirect_to new_dataload_mailchimp_path
    else

      # lists(string apikey, array filters, int start, int limit, string sort_field, string sort_dir)
      # http://apidocs.mailchimp.com/api/1.3/lists.func.php
      # Retrieve all of the lists defined for your user account
      #
      # lists = gb.lists
      gibbon = Gibbon.new(@dataload.api_key)
      @lists = []
      gibbon.lists['data'].each do |list|
        @lists << MailchimpList.find_or_create_by_list_id(:list_id => list['id'], :name => list['name'])
      end
    end
  end

  # POST /dataload_mailchimps
  # POST /dataload_mailchimps.json
  def create
    @dataload = DataloadMailchimp.new(params[:dataload_mailchimp])

    respond_to do |format|
      if @dataload.save
        format.html { redirect_to edit_dataload_mailchimp_path, notice: 'Dataload mailchimp was successfully created.' }
        format.json { render json: @dataload, status: :created, location: @dataload }
      else
        format.html { render action: "new" }
        format.json { render json: @dataload.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /dataload_mailchimps/1
  # PUT /dataload_mailchimps/1.json
  def update
    @dataload = DataloadMailchimp.first

    respond_to do |format|
      if @dataload.update_attributes(params[:dataload_mailchimp])
        format.html { redirect_to edit_dataload_mailchimp_path, notice: 'Dataload mailchimp was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @dataload.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /dataload_mailchimps/1
  # DELETE /dataload_mailchimps/1.json
  def destroy
    @dataload_mailchimp = DataloadMailchimp.find(params[:id])
    @dataload_mailchimp.destroy

    respond_to do |format|
      format.html { redirect_to dataload_mailchimps_url }
      format.json { head :no_content }
    end
  end
end
