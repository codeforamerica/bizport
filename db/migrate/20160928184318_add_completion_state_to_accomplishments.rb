class AddCompletionStateToAccomplishments < ActiveRecord::Migration
  def change
    add_column :accomplishments, :completed, :boolean
    add_column :accomplishments, :disabled, :boolean
  end
end
