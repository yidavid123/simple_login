class UserMailer < ApplicationMailer
  default from: 'sandave72@gmail.com'

  def welcome_email
    user = params[:user]
    url  = 'http://davidyi.com/login'
    mail(to: user.email_address, subject: 'Welcome to My Awesome ROR LOGIN')
  end

  def recovery_email
    user = params[:user]
    url  = 'http://davidyi.com/login'
    mail(to: user.email_address, subject: 'Username and Password Recovery ROR LOGIN')
  end

end
