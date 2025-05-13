class TransactionsController < ApplicationController
    def create
       @transaction = Transaction.new(transaction_params)
       @transaction.user = current_user
       @transaction.total_price = @transaction.stock_price_per_share.to_f * @transaction.quantity.to_f

       puts "Stock Name: #{@transaction.stock_name}"
       puts "Stock Price: #{@transaction.stock_price_per_share}"
       puts "Quantity: #{@transaction.quantity}"
       puts "Calculated Total Price: #{@transaction.total_price}"
       puts "Transaction Type: #{@transaction.transaction_type}"
       puts "Current User: #{@transaction.user}"


        if @transaction.transaction_type === "Buy"
            if current_user.is_approved == true
                if current_user.balance.to_f > @transaction.stock_price_per_share.to_f * @transaction.quantity.to_i
                    @transaction.save
                    update_holdings(@transaction)
                    current_user.balance -= @transaction.total_price
                    current_user.save
                    flash[:notice] = "Transaction was successfully created."
                    redirect_to transaction_path(@transaction)
                else
                    flash[:error] = "Insufficient balance."
                    redirect_to root_path
                end
            else
                flash[:error] = "Your account needs to be approved before you can make transactions."
                redirect_to root_path
            end
        elsif @transaction.transaction_type === "Sell"
            if current_user.is_approved == true
                holding = current_user.holdings.find_by(stock_name: @transaction.stock_name)
                if holding.nil? || holding.total_shares_owned < @transaction.quantity
                    flash[:error] = "Transaction failed: You do not have enough shares to sell."
                    redirect_to root_path
                else
                    @transaction.save
                    update_holdings(@transaction)
                    current_user.balance += @transaction.total_price
                    current_user.save
                    flash[:notice] = "Transaction was successfully created."
                    redirect_to transaction_path(@transaction)
                end
            else
                flash[:error] = "Your account needs to be approved before you can make transactions."
                redirect_to root_path
            end
        end
    end

    def index
        @user_stock_names = current_user.transactions.distinct.pluck(:stock_name)

        if params[:symbol].present? && params[:symbol] != "All"
            @transactions = current_user.transactions.where(stock_name: params[:symbol])
        else
            @transactions = current_user.transactions
        end
    end

    def show
        @transaction = Transaction.find(params[:id])
    end

    private

    def transaction_params
        params.require(:transaction).permit(:stock_name, :stock_price_per_share, :quantity, :transaction_type)
    end

    def update_holdings(transaction)
        holding = Holding.find_or_initialize_by(user: transaction.user, stock_name: transaction.stock_name)

        buys = transaction.user.transactions.where(stock_name: transaction.stock_name, transaction_type: "Buy")
        sells = transaction.user.transactions.where(stock_name: transaction.stock_name, transaction_type: "Sell")

        total_quantity_bought = buys.sum { |t| t.quantity.to_f }
        total_quantity_sold = sells.sum { |t| t.quantity.to_f }
        total_shares_owned = total_quantity_bought - total_quantity_sold

        total_spent = buys.sum { |t| t.total_price }
        ave_buy_price = total_shares_owned > 0 ? (total_spent.to_f / total_quantity_bought.to_f.round(2)) : 0

        total_value = total_shares_owned * ave_buy_price.to_f.round(2)

        holding.total_shares_owned = total_shares_owned
        holding.average_buy_price = ave_buy_price
        holding.total_value = total_value

        holding.save
    end
end
