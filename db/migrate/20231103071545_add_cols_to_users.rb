class AddColsToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :country_code, :integer
    add_column :users, :phone_number, :bigint
  end
end
