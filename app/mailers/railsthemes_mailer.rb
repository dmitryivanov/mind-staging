class RailsthemesMailer < ActionMailer::Base
  helper RailsthemesMailerHelper
  layout 'railsthemes_mailer'

  def test_email options = {}
    mail :from => "example@railsthemes.com", :to => options[:to]
  end
end
