class RenameQuantityToTotalSharesOwnedInHoldings < ActiveRecord::Migration[8.0]
  def change
    rename_column :holdings, :quantity, :total_shares_owned
  end
end
