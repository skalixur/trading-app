class HoldingsController < ApplicationController
    def index
        @transactions = current_user.transactions

        @holdings = @transactions.group_by { |t| t.stock_name}.map do |stock_name, transactions|
            buys = transactions.select { |t| t.transaction_type == "Buy" }
            sells = transactions.select { |t| t.transaction_type == "Sell"}

            total_quantity_bought = buys.sum { |t| t.quantity}
            total_quantity_sold = sells.sum { |t| t.quantity}
            total_shares_owned = total_quantity_bought - total_quantity_sold

            total_spent = buys.sum { |t| t.total_price }
            ave_buy_price = total_spent > 0 ? (total_spent / total_quantity_bought ) : 0

            {
                stock_name: stock_name,
                total_shares_owned: total_shares_owned,
                average_buy_price: ave_buy_price.round(2),
                total_value: (total_shares_owned * ave_buy_price).round(2)
            }
        end.reject { |h| h[:total_shares_owned] <= 0 }
    end
end
