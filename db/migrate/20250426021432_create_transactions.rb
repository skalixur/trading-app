class CreateTransactions < ActiveRecord::Migration[8.0]
  def change
    create_table :transactions do |t|
      t.references :user, null: false, foreign_key: true
      t.string :stock_name
      t.decimal :quantity
      t.decimal :stock_price_per_share
      t.decimal :total_price
      t.string :transaction_type

      t.timestamps
    end
  end
end
