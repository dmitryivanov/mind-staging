require 'spec_helper'

describe DataloadGasController do
  
  let(:dataload_ga) { FactoryGirl.build_stubbed(:dataload_ga) }
  let(:attributes) { FactoryGirl.attributes_for(:dataload_ga).stringify_keys }
  
  describe "GET #index" do
      
    before(:each) do
      DataloadGa.stub(:all).and_return([dataload_ga])
    end

    it "loads the resource" do
      DataloadGa.should_receive(:all)
      get :index
    end
    
    it "populates an array of resources" do
      get :index
      assigns(:dataload_gas).should eq([dataload_ga])
    end
    
    it "renders the :index view" do
      get :index
      response.should render_template :index
    end
  end
  
  # describe "GET #show" do    
  #   
  #   it "assigns resource" do
  #     get :show, id: @resource
  #     assigns(resource_name).should eq(@resource)
  #   end
  #   
  #   it "renders the :show template" do
  #     get :show, id: @resource
  #     response.should render_template :show
  #   end
  # end
  
  describe "GET #new" do
    
    it "builds new resource " do
      DataloadGa.should_receive(:new)
      get :new
    end
    
    it "renders new template" do
      get :new  
      response.should render_template :new
    end      
  end

  describe "POST #create" do    
    
    before(:each) do
      current_dataload_ga = dataload_ga
      DataloadGa.stub(:new).and_return(current_dataload_ga)
    end
    
    it "builds and saves resouce" do
      DataloadGa.should_receive(:new).with(attributes).and_return(dataload_ga)
      dataload_ga.should_receive(:save)
      post :create, dataload_ga: attributes
    end
    
    context "with valid attributes" do
      
      before(:each) do
        dataload_ga.stub(:save).and_return(true)
        dataload_ga.stub(:id).and_return(1)
      end
      
      it "redirects to edit action" do
        post :create, dataload_ga: attributes
        response.should redirect_to :action => :edit, :id => assigns[:dataload_ga]
      end
      
      it "sets flash message" do
        post :create, dataload_ga: attributes
        flash[:notice].should_not be_empty
      end
      
    end
  
    context "with invalid attributes" do
      
      before(:each) do
        dataload_ga.stub(:save).and_return(false)
      end
      
      it "re-renders new template" do
        post :create, dataload_ga: attributes
        response.should render_template :new
      end
    end
  end

  describe "GET #edit" do
    
    it "assigns resource" do   
      DataloadGa.should_receive(:find).with(dataload_ga.id.to_s).and_return(dataload_ga)
      get :edit, id: dataload_ga.id
      assigns(:dataload_ga).should eq(dataload_ga)
    end
  
    it "renders edit template" do
      DataloadGa.stub(:find)
      get :edit, id: dataload_ga
      response.should render_template :edit
    end
   
  end
  
  describe "PUT #update" do

    before(:each) do
      DataloadGa.stub(:find).and_return(dataload_ga)
    end
    
    context "when commit != Next" do
      
      it "redirects to edit" do
        put :update, id: dataload_ga, dataload_ga: attributes
        response.should redirect_to :action => :edit, :id => dataload_ga
      end
      
    end

    context "when commit == Next" do
      
      after(:each) do
        put :update, id: dataload_ga, commit: 'Next', dataload_ga: attributes
      end
              
      it "loads resource" do
        DataloadGa.should_receive(:find).with(dataload_ga.id.to_s)        
      end
      
      it "assigns new attributes" do
        dataload_ga.should_receive(:assign_attributes).with(attributes)
      end
      
      it "calls next_step for model" do
        dataload_ga.should_receive(:next_step)
      end
      
    end
    
    context "after response" do      
      
      it "renders edit template" do
        put :update, id: dataload_ga, commit: 'Next', dataload_ga: attributes
        response.should render_template :edit
      end
        
      
      it "sets flash notice when next_step successfull" do
        dataload_ga.stub(:next_step).and_return(true)
        put :update, id: dataload_ga, commit: 'Next', dataload_ga: attributes
        flash[:notice].should_not be_empty
      end
      
      it "sets flash alert when next_step successfull" do
        dataload_ga.stub(:next_step).and_return(true)
        put :update, id: dataload_ga, commit: 'Next', dataload_ga: attributes
        flash[:notice].should_not be_empty
      end
    end
    
  end
      

  #   
  #   it "finds requested resourse", :vcr do
  #     put :update, id: @resource, resource_name => FactoryGirl.attributes_for(resource_name)
  #     assigns(resource_name).should eq(@resource)      
  #   end
  #   
  #   context "with valid attributes" do
  #     before(:each) do
  #       VCR.use_cassette('dataload_gas_controller/update_with_valid_attributes_before_each') do
  #         put :update, id: @resource, resource_name => FactoryGirl.attributes_for(
  #           resource_name
  #         )
  #       end
  #     end
  #     
  #     it "updates resource in database", :vcr do
  #       @resource.reload
  #       @resource.ga_username.should eq(FactoryGirl.attributes_for(:dataload_ga)[:ga_username])
  #       @resource.ga_password.should eq(FactoryGirl.attributes_for(:dataload_ga)[:ga_password])
  #     end
  #     
  #     it "redirects to edit action", :vcr do
  #       response.should redirect_to :action => :edit, :id => @resource
  #     end
  #     
  #     it "sets flash message", :vcr do
  #       flash[:notice].should_not be_empty
  #     end
  #   end
  # 
  #   context "with invalid attributes" do
  #     before(:each) do
  #       VCR.use_cassette('dataload_gas_controller/update_with_invalid_attributes_before_each') do
  #         put :update, id: @resource, resource_name => FactoryGirl.attributes_for(
  #           resource_name, 
  #           ga_username: "Larry", 
  #           ga_password: "Larrys password"
  #         )
  #       end
  #     end
  #     
  #     it "does not update resource in database" do
  #       @resource.reload
  #       @resource.ga_username.should_not eq("Larry")
  #       @resource.ga_password.should_not eq("Larrys password")
  #     end
  #     
  #     it "re-renders edit template" do
  #       response.should render_template :edit
  #     end
  #   end
  # end 
  
  # describe "DELETE #destroy" do
  #   it "finds requested resourse" do
  #     delete :destroy, id: @resource
  #     assigns(resource_name).should eq(@resource)
  #   end
  #   
  #   it 'destroys resource' do
  #     expect{
  #       delete :destroy, id: @resource        
  #     }.to change(resource_name.classify.constantize, :count).by(-1)
  #   end
  #   
  #   it 'redirects to index action' do
  #     delete :destroy, id: @resource
  #     response.should redirect_to :action => :index
  #   end
  # end
    
end
