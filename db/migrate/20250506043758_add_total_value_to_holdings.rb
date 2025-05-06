class AddTotalValueToHoldings < ActiveRecord::Migration[8.0]
  def change
    add_column :holdings, :total_value, :decimal
  end
end
