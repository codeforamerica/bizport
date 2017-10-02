class CreateQuestions < ActiveRecord::Migration
  def change
    create_table :questions do |t|
      t.string :question_text
      t.string :question_source
      t.boolean :live_on_site, default: false

      t.timestamps
    end
  end
end
