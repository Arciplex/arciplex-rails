class UserMailerWorker
  include Sidekiq::Worker

  def perform(user_id, temp_password)
    @user = User.find(user_id)
    UserMailer.welcome(@user, temp_password).deliver
  end
end
