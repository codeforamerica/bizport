class ChecklistsController < ApplicationController
  def show
    # if the user is coming here after logging in or signing up
    # they'll have a set of checklist items that need to set accomplishments
    if user_signed_in? && (items = session[:checklist_updates])
      checklist_items = ChecklistItem.where(id: items.map(&:to_i))
      set_accomplishments(checklist_items)
      session.delete(:checklist_updates)
    end

    @accomplishment_ids = current_user.checklist_items.pluck(:id)
  end

  def update
    if user_signed_in?
      # "checklist_items"=>["164", "166", "168", "170"]
      checklist_items = ChecklistItem.where(id: params['checklist_items'].map(&:to_i))
      set_accomplishments(checklist_items)

      redirect_to checklist_path
    else
      store_location_for(:user, checklist_path)
      session[:checklist_updates] = params['checklist_items']
      redirect_to new_user_registration_path
    end
  end

  def set_accomplishments(checklist_items)
    ActiveRecord::Base.transaction do
      current_user.accomplishments.destroy_all
      checklist_items.each do |item|
        current_user.accomplishments.create!(checklist_item: item)
      end
    end
  end
end
