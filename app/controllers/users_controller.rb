class UsersController < ApplicationController
  before_action :authenticate_user!

  def edit
    @user = current_user
  end

  # PATCH/PUT
  def update
    @user = User.find(current_user.id)
    if @user.update_attributes(user_params)
      flash[:notice] = 'Account email updated.'
      redirect_to dashboard_path
    else
      render 'edit'
    end
  end

  private

  def user_params
    params.require(:user).permit(:email)
  end
end
