class AddCreatedByUserIdToChecklistItems < ActiveRecord::Migration
  def change
    add_column :checklist_items, :created_by_user_id, :integer
  end
end
