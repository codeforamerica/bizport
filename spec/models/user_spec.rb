require 'rails_helper'

describe User do
  describe '#all_checklist_items' do
    let(:user) { FactoryBot.create(:user_with_custom_checklist_items) }
    it 'should always return all default checklist items' do
      user_items = user.all_checklist_items
      default_items = *ChecklistItem.where(created_by_user_id: nil)
      expect(user_items).to include(*default_items)
    end
    it 'should include only custom checklist items created by the user' do
      other_user = FactoryBot.create(:user_with_custom_checklist_items)
      user_items = user.all_checklist_items

      custom_items = ChecklistItem.where(created_by_user_id: user.id)
      other_user_items = ChecklistItem.where(created_by_user_id: other_user.id)
      expect(user_items).to include(*custom_items)
      expect(user_items).not_to include(*other_user_items)
    end
  end
end
