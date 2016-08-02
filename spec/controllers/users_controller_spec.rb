require 'rails_helper'

describe UsersController, type: :controller do
  context 'without a logged-in user' do
    describe 'when visiting the user dashboard' do
      it 'should redirect to the sign-in page' do
        get :edit
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end
  context 'with a logged-in user' do
    describe 'the user dashboard' do
      it 'should render the dashboard form template' do
        user = FactoryGirl.create(:user)
        sign_in user
        get :edit
        expect(response).to render_template('users/edit')
      end
      it 'should save a new email address' do
        user = FactoryGirl.create(:user)
        sign_in user
        old_email = user.email

        new_email = 'new@email.com'
        put :update, user: { email: new_email }

        user.reload
        expect(user.email).not_to eq(old_email)
        expect(user.email).to eq(new_email)
        expect(response).to redirect_to(dashboard_path)
        expect(flash[:notice]).to eq('Account email updated.')
      end
    end
  end
end
