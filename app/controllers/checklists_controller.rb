class ChecklistsController < ApplicationController
  def update
    if user_signed_in?
      # "checklist_items"=>["164", "166", "168", "170"]
      checklist_ids = []
      if params['checklist_items']
        checklist_ids = params['checklist_items'].map(&:to_i)
      end
      checklist_items = ChecklistItem.where(id: checklist_ids)
      checklist_categories = params['categories']
      ChecklistHelper.set_accomplishments(current_user, checklist_categories, checklist_items)

      redirect_to request.referer || '/profile'
    else
      session[:checklist_updates] = {
        "categories" => params['categories'] || '',
        "items" => params['checklist_items'] || [],
        "source_page" => request.referer
      }
      redirect_to new_user_registration_path
    end
  end
end
