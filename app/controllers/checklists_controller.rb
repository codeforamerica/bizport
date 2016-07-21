class ChecklistsController < ApplicationController
  def show
    @accomplishment_ids = current_user.checklist_items.pluck(:id)
  end

  def update
    if current_user
      # "checklist_items"=>["164", "166", "168", "170"]
      checklist_items = ChecklistItem.where(id: params["checklist_items"].map(&:to_i))

      set_accomplishments(checklist_items)

      redirect_to checklist_path
    else
      # TODO: Store the params in session for when they finish sign-in/up
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
