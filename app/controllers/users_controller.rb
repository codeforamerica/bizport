class UsersController < ApplicationController
  before_action :authenticate_user!

  def edit
    @user = current_user
  end

  # PUT
  def update
    @user = User.find(current_user.id)
    if @user.update_attributes(user_params.reject { |_k, v| v.blank? })
      flash[:notice] = 'Account updated.'
      redirect_to action: :profile
    else
      flash[:alert] = 'Account not updated. Please try again.'
      redirect_to action: :edit
    end
  end

  def profile
    @user = current_user
    @notebook_items = @user.get_notebook.attributes
      .reject!{ |attrib| ["id","user_id","created_at","updated_at"].include? attrib }
      .map{|item| {slug: item[0], name: NOTEBOOK_LABELS[item[0].to_sym], value: item[1]} }
    render 'profile'
  end

  def profile_update
    @user = current_user
    @user.get_notebook.update(notebook_params)
    render(json: {
             notebook: notebook_params,
             status: 'OK'
           })
  end

  private

  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation)
  end

  def notebook_params
    params.require(:notebook).permit!
  end
end
