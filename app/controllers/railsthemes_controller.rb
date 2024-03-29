class RailsthemesController < ApplicationController
def email
end

def send_email
  RailsthemesMailer.test_email(:to => params[:email]).deliver
  render :sent_email
end

  # normally every view will use your application layout
  def inner
    render :layout => 'application'
  end

  # this is a special layout for landing and home pages
  def landing
    render :layout => 'landing'
  end
end
