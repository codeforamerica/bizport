class CreateChecklistItems < ActiveRecord::Migration[5.0]
  def change
    create_table :checklist_items do |t|
      t.string :item_text
      t.string :category
      t.integer :order_number

      t.timestamps
    end
  end
end
