class HomeController < ApplicationController
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
  end
end
