require 'rails_helper'

describe UsersController, type: :controller do
  context 'without a logged-in user' do
    describe 'when visiting the user profile' do
      it 'should redirect to the sign-up page' do
        get :profile
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end
  context 'with a logged-in user' do
    let(:user) { FactoryBot.create(:user) }
    before :each do
      sign_in user
    end
    describe 'the user profile' do
      it 'should render the profile form template' do
        get :profile
        expect(response).to render_template('users/profile')
      end
      it 'should save a new email address' do
        old_email = user.email

        new_email = 'new@email.com'
        put :update, user: { email: new_email }

        user.reload
        expect(user.email).not_to eq(old_email)
        expect(user.email).to eq(new_email)
        expect(response).to redirect_to(profile_path)
        expect(flash[:notice]).to eq('Account updated.')
      end
    end
    describe 'the account settings page' do
      it 'should render the users edit template' do
        get :profile
        expect(response).to render_template('users/profile')
      end
    end
  end
end
