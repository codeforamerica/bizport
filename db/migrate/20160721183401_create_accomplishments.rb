class CreateAccomplishments < ActiveRecord::Migration
  def change
    create_table :accomplishments do |t|
      t.belongs_to :user, index: true, foreign_key: true
      t.belongs_to :checklist_item, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
