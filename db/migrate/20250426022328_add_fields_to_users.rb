class AddFieldsToUsers < ActiveRecord::Migration[8.0]
  def change
    add_column :users, :name, :string
    add_column :users, :balance, :decimal
    add_column :users, :is_approved, :boolean
    add_column :users, :is_admin, :boolean
  end
end
