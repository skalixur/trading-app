class CreateHoldings < ActiveRecord::Migration[8.0]
  def change
    create_table :holdings do |t|
      t.references :user, null: false, foreign_key: true
      t.string :stock_name
      t.decimal :quantity
      t.decimal :average_price

      t.timestamps
    end
  end
end
