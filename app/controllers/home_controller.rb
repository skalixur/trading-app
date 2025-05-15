class HomeController < ApplicationController
  include ActionView::Helpers::NumberHelper
  def index
    if params[:symbol].present?
        response = AvaApi.fetch_records(params[:symbol])

        if response["Meta Data"]
          @stock_name = response["Meta Data"]["2. Symbol"]
          @stock_price_per_share = response.dig("Time Series (Daily)").values.first.dig("1. open")
          @transaction = Transaction.new
        else
          @error = "Invalid symbol or API error."
        end
    else
      @transaction = Transaction.new
    end
    @deposit = current_user.balance
    @buy = Transaction.where(transaction_type: "Buy", user_id: current_user.id).sum(:total_price)
    @sell = Transaction.where(transaction_type: "Sell", user_id: current_user.id).sum(:total_price)
    @balance = (@deposit + @buy)- @sell
    @balance = ActiveSupport::NumberHelper.number_to_delimited(@balance)
  end
end
