class ChecklistsController < ApplicationController
  def show
    # if the user is coming here after logging in or signing up
    # they'll have a set of checklist items that need to set accomplishments
    if user_signed_in? && (updates = session[:checklist_updates])
      session.delete(:checklist_updates)
      categories = updates["categories"]
      checklist_items = ChecklistItem.where(
        id: updates["items"].map(&:to_i),
        category: categories
      )
      set_accomplishments(categories, checklist_items)

      redirect_to updates['source_page'] if updates['source_page']
    end

    @done_ids = []
    @done_ids = current_user.checklist_items.pluck(:id) if current_user
  end

  def update
    if user_signed_in?
      # "checklist_items"=>["164", "166", "168", "170"]
      checklist_ids = []
      if params['checklist_items']
        checklist_ids = params['checklist_items'].map(&:to_i)
      end
      checklist_items = ChecklistItem.where(id: checklist_ids)
      checklist_categories = params['categories']
      set_accomplishments(checklist_categories, checklist_items)

      redirect_to request.referer || '/checklist'
    else
      session[:checklist_updates] = {
        "categories" => params['categories'] || '',
        "items" => params['checklist_items'] || [],
        "source_page" => request.referer
      }
      redirect_to new_user_registration_path
    end
  end

  def set_accomplishments(checklist_categories, checklist_items)
    ActiveRecord::Base.transaction do
      current_user.accomplishments
        .joins(:checklist_item)
        .where(checklist_items: { category: checklist_categories })
        .destroy_all
      checklist_items.each do |item|
        current_user.accomplishments.create!(checklist_item: item)
      end
    end
  end
end
