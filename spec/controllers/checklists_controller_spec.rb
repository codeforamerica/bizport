require 'rails_helper'

describe ChecklistsController do
  let(:user) { FactoryGirl.create(:user) }

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
    context 'with a logged-in user' do
      it 'should create an accomplishment record' do
        allow(controller).to receive(:current_user).and_return(user)
        checklist_item = ChecklistItem.take

        expect do
          patch :update, 'categories' => [checklist_item.category],
                         'checklist_items' => [checklist_item.id.to_s]
        end.to change(Accomplishment, :count).by(1)

        expect(response).to redirect_to(profile_path)
      end

      it 'should remove unchecked accomplishment records from the same category' do
        allow(controller).to receive(:current_user).and_return(user)

        categories = ChecklistItem.pluck(:category).uniq
        category_a = categories.first
        category_b = categories.second

        item_1_cat_a = ChecklistItem.find_by(category: category_a)
        item_2_cat_a = ChecklistItem.find_by(category: category_a)
        item_3_cat_b = ChecklistItem.find_by(category: category_b)

        user.accomplishments.create(checklist_item: item_1_cat_a)
        user.accomplishments.create(checklist_item: item_2_cat_a)
        user.accomplishments.create(checklist_item: item_3_cat_b)

        expect do
          patch :update, 'categories' => [category_a],
                         'checklist_items' => [item_1_cat_a.id.to_s]
        end.to change {
          cat_a_count = user.checklist_items.where(category: category_a).count
          cat_b_count = user.checklist_items.where(category: category_b).count
          [cat_a_count, cat_b_count]
        }.from([2, 1]).to([1, 1])
      end
    end

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
