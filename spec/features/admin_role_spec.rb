require 'rails_helper'

describe 'admin authorization' do
  context 'without a logged-in user' do
    it 'should not 404 the user' do
      expect{ visit '/admin' }.not_to raise_error
    end
  end
  context 'with a logged-in user' do
    context "with role: nil" do
      it 'should throw a 404 when a non-admin user tries to view /admin' do
        user = FactoryGirl.create(:user, role: nil)
        login_as(user, scope: :user, run_callbacks: false)
        expect{ visit '/admin' }.to raise_error(ActionController::RoutingError)
      end
    end
    context "with a role: '' user" do
      it 'should throw a 404 when a non-admin user tries to view /admin' do
        user = FactoryGirl.create(:user, role: nil)
        login_as(user, scope: :user, run_callbacks: false)
        expect{ visit '/admin' }.to raise_error(ActionController::RoutingError)
      end
    end
  end
end
