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

  def update_item
    if user_signed_in?
      if checklist_item_params[:checked] == 'true'
        Accomplishment.find_or_create_by(
          user: current_user, 
          checklist_item_id: checklist_item_params[:id]
        )
        render(json: {
                 id: checklist_item_params[:id],
                 checked: true
               })
      else
        Accomplishment.find_by(
          user: current_user,
          checklist_item_id: checklist_item_params[:id]
        ).destroy
        render(json: {
                 id: checklist_item_params[:id],
                 checked: false
               })
      end
    end
  end

  private

  def checklist_item_params
    params.require(:checklist_item).permit(:id, :checked)
  end
end
