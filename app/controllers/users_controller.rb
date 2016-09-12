class UsersController < ApplicationController
  before_action :authenticate_user!

  def edit
    @user = current_user
  end

  # PUT
  def update
    @user = User.find(current_user.id)
    if @user.update_attributes(user_params.reject{|k, v| v.blank?})
      flash[:notice] = 'Account updated.'
      redirect_to action: :profile
    else
      flash[:alert] = 'Account not updated. Please try again.'
      redirect_to action: :edit
    end
  end

  def profile
    @user = current_user
    render 'profile'
  end

  private

  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation)
  end
end
