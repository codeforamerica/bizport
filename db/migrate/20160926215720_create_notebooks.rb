class CreateNotebooks < ActiveRecord::Migration
  def change
    create_table :notebooks do |t|
      t.integer :user_id
      t.string :business_license
      t.string :zip_code
      t.string :e_account
      t.string :state_sellers_permit
      t.string :additional_state_license
      t.string :business_structure
      t.string :dba_name
      t.string :business_type
      t.integer :no_of_employees
      t.string :street_address
      t.string :zip_code
      t.string :bid
      t.integer :square_footage
      t.integer :no_parking_spaces

      t.timestamps null: false
    end
    add_index :notebooks, :user_id
  end
end
