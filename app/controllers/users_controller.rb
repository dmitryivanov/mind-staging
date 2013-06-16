class UsersController < ApplicationController
    # should restrict access to logged in visitors only
  before_filter :authenticate_user!
      
    def new
        @user = User.new
    end
    
    def create
      @user = User.new(params[:user])
      if @user.save
          session[:user_id] = @user.id
          redirect_to users_path, notice: "thank you for signing up!"
      else 
          render :new
      end
    end
    
    def index
        if params[:search] 
            @users = User.paginate(:page => params[:page], per_page: 10, :conditions => ["email LIKE ?", "%#{params[:search]}%"])
            if @users.size.zero?
                flash[:notice] = "No results found"
            end
        else
            @users = User.paginate(:page => params[:page], per_page: 10) 
        end

        respond_to do |format|
          format.html # index.html.erb
        end
    end
    
end
