class HoldingsController < ApplicationController
    def index
        @holdings = current_user.holdings
    end
end
