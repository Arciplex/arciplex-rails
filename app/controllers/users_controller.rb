class UsersController < ApplicationController

  before_filter :authenticate_user!

  respond_to :js

  def update_password
    @user = User.find(current_user.id)

    if @user.update(user_params)
      sign_in @user, bypass: true
      redirect_to after_sign_in_path_for(@user), notice: "Password Updated!"
    else
      redirect_to after_sign_in_path_for(@user), notice: "#{@user.errors.full_messages.to_sentence}"
    end
  end

  private
    def user_params
      params.require(:user).permit(:password, :password_confirmation)
    end

end
