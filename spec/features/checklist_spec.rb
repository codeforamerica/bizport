require 'rails_helper'

describe 'the checklist page', type: :feature do

  it 'renders with some checklist items' do
    visit '/checklist'
    expect(page).to have_content ChecklistItem.first.category_name
  end

end
