class UserMailer < ActionMailer::Base
  default from: "admin@arciplex.com"

  def welcome(user, password)
    @user = user
    @company_name = @user.company_name
    @password = password
    mail(to: @user.email, subject: "Service Request Submitted")
  end
end
