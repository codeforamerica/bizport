require 'rails_helper'

describe 'the profile page', type: :feature do
  it 'renders with some profile items' do
    visit '/profile'
    expect(page).to have_content ChecklistItem.first.category_name
  end

  context 'user is not signed in' do
    it 'prompts users to sign in on save' do
      visit '/profile'
      first("input[type='checkbox']").set(true)
      click_on('Save My Progress', match: :first)

      expect(current_path).to eq(new_user_registration_path)
    end
  end

  context 'user is signed in' do
    xit 'lets users save their checked items' do
      user = FactoryGirl.create(:user)
      login_as(user, scope: :user, run_callbacks: false)

      visit '/profile'
      first("input[type='checkbox']").set(true)
      click_on('Save My Progress', match: :first)

      expect(current_path).to eq(profile_path)
      expect(first("input[type='checkbox']")).to be_checked
    end
  end
end
