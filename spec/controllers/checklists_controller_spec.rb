require 'rails_helper'

describe ChecklistsController do
  describe '#update' do
    context 'with a logged in user' do
      it 'should create an accomplishment record' do
        user = FactoryGirl.create(:user)
        allow(controller).to receive(:current_user).and_return(user)
        checklist_item = ChecklistItem.take

        expect do
          patch :update, { "checklist_items" => [checklist_item.id.to_s] }
        end.to change(Accomplishment, :count).by(1)

        expect(response).to render_template(:show)
      end

      xit 'should remove any unchecked accomplishment records from the same cateogry' do
      end

      xit 'should not remove unchecked accomplishment records from other categories' do
      end
    end

    context 'with no logged in user' do
      it 'should redirect the user to sign up' do
        checklist_item = ChecklistItem.take

        patch :update, { 'checklist_items' => [checklist_item.id.to_s] }

        expect(response).to redirect_to(new_user_registration_path)
      end
    end
  end
end
