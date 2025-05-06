class RenameAveragePriceToAverageBuyPrice < ActiveRecord::Migration[8.0]
  def change
    rename_column :holdings, :average_price, :average_buy_price
  end
end
