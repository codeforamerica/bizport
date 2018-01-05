require 'rails_helper'

describe ChecklistsController do
  let(:user) { FactoryBot.create(:user) }

  xdescribe '#show' do
    context 'with a logged-in user' do
      context 'when accomplishments are waiting to be updated (e.g. after login)' do
        it 'should update checklist items' do
          allow(controller).to receive(:current_user).and_return(user)

          checklist_item = ChecklistItem.take
          session[:checklist_updates] = {
            'categories' => [checklist_item.category],
            'items' => [checklist_item.id.to_s]
          }
          expect do
            get :show
          end.to change(Accomplishment, :count).by(1)

          expect(response).to render_template(:show)
        end

        context 'when no accomplishments are waiting to be updated' do
          it 'should not change accomplishments' do
            user.accomplishments.create(checklist_item: ChecklistItem.take)
            allow(controller).to receive(:current_user).and_return(user)

            expect do
              get :show
            end.not_to change(user.accomplishments, :count)

            expect(response).to render_template(:show)
          end
        end
      end
    end
  end

  describe '#update' do
    context 'with no logged-in user' do
      it 'should redirect the user to sign up' do
        checklist_item = ChecklistItem.take

        patch :update, 'categories' => [checklist_item.category],
                       'checklist_items' => [checklist_item.id.to_s]

        expect(response).to redirect_to(new_user_registration_path)
      end
    end
  end
end
