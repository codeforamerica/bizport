require 'rails_helper'

describe 'save a step page checklist' do

  context 'when not logged in' do
    xit 'should redirect the user back to the step page after signup' do
      # any arbitrary CMS page is a good starting point
      starting_path = Comfy::Cms::Page.published.last.full_path
      visit starting_path

      click_on('Save My Progress')

      expect(current_path).to eq(new_user_registration_path)

      user_password = Faker::Internet.password
      page.fill_in('Email', with: Faker::Internet.email)
      page.fill_in('Password', with: user_password)
      page.fill_in('Password confirmation', with: user_password)

      click_button('Sign Up')

      expect(current_path).to eq(starting_path)
    end
  end

  context 'when logged in' do
    xit 'should redirect back to the same step page' do
      login_as(FactoryBot.create(:user), scope: :user)

      # any arbitrary CMS page is a good starting point
      starting_path = Comfy::Cms::Page.published.last.full_path
      visit starting_path

      click_on('Save My Progress')

      expect(current_path).to eq(starting_path)
    end
  end
end
