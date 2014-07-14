class UserMailer < ActionMailer::Base
  default from: "admin@arciplex.com"

  def welcome(user, password)
    @user = user
    @company_name = @user.companies.first.name
    @password = password
    mail(to: @user.email, subject: "Welcome to ArciPlex")
  end
end
