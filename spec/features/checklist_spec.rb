require 'rails_helper'

describe 'the checklist page', type: :feature do

  it 'renders with some checklist items' do
    visit '/checklist'
    expect(page).to have_content ChecklistItem.first.category_name
  end

  context "user is not signed in" do
    it 'prompts users to sign in on save' do
      visit '/checklist'
      first("input[type='checkbox']").set(true)
      click_on 'Save My Progress'

      expect(current_path).to eq(new_user_registration_path)
    end
  end

  context 'user is signed in' do
    it 'lets users save their checked items' do
      user = FactoryGirl.create(:user)
      login_as(user, scope: :user, run_callbacks: false)

      visit '/checklist'
      first("input[type='checkbox']").set(true)
      click_on 'Save My Progress'

      expect(current_path).to eq(checklist_path)
      expect(first("input[type='checkbox']")).to be_checked
    end
  end
end
