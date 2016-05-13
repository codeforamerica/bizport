class CreateGlossaryItems < ActiveRecord::Migration
  def change
    create_table :glossary_items do |t|
      t.string :term
      t.string :definition

      t.timestamps
    end
  end
end
