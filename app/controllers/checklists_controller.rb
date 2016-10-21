class ChecklistsController < ApplicationController
  # PATCH /checklist
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

  # PUT /checklist
  def update_item
    if user_signed_in?
      accomplishment = Accomplishment.find_or_create_by(
        user: current_user, 
        checklist_item_id: checklist_item_params[:id]
      )
      accomplishment.update_attributes(
        completed: checklist_item_params[:completed] == 'true',
        disabled: checklist_item_params[:disabled] == 'true'
      )
      render(json: {
               id: checklist_item_params[:id],
               completed: checklist_item_params[:completed],
               disabled: checklist_item_params[:disabled]
             })
    end
  end

  private

  def checklist_item_params
    params.require(:checklist_item).permit(:id, :completed, :disabled)
  end
end
