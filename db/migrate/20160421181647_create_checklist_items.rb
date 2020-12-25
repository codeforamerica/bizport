class CreateChecklistItems < ActiveRecord::Migration
  def change
    create_table :checklist_items do |t|
      t.string :item_text
      t.string :category
      t.string :category_name
      t.integer :order_number

      t.timestamps
    end
  end
end
