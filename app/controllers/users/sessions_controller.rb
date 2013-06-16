class Users::SessionsController < Devise::SessionsController
  def new
    super
  end
  
  def create  
    account_domain = params[:user][:accounts][:domain]
    email = params[:user][:email]
    account = Account.find(:first, :conditions => ['domain=?', account_domain])        
    unless account.nil?
      user = User.find(:first, :conditions=>['email=:email AND account_id=:account_id',{:email => email, :account_id => account.id}])
      if user
        super
      else
        flash[:error] = "No user in " + account_name + " Account"
        redirect_to root_path
      end
    else
      flash[:error] = "Invalid account"
      redirect_to root_path
    end
  end
  
  def destroy
    super
  end
end
