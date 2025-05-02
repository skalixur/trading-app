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
       

       if @transaction.save
            flash[:notice] = "Transaction was successfully created."
            redirect_to transaction_path(@transaction)
       else
            flash[:error] = "There was an error with your transaction."
            redirect_to root_path
       end
    end

    def show
        @transaction = Transaction.find(params[:id])
    end

    private

    def transaction_params
        params.require(:transaction).permit(:stock_name, :stock_price_per_share, :quantity, :transaction_type)
    end
end
