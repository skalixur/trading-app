require 'rails_helper'

RSpec.describe Holding, type: :model do
  context 'validations' do
    it 'is valid with valid attributes' do
      holding = Holding.new(stock_name: 'AAPL', total_shares_owned: 10, average_buy_price: 150.0, total_value: 1500.0, user: User.new)
      expect(holding).to be_valid
    end

    it 'is not valid without a stock_name' do
      holding = Holding.new(stock_name: nil, total_shares_owned: 10, average_buy_price: 150.0, total_value: 1500.0, user: User.new)
      expect(holding).not_to be_valid
    end

    it 'is not valid with negative total_shares_owned' do
      holding = Holding.new(stock_name: 'AAPL', total_shares_owned: -1, average_buy_price: 150.0, total_value: 1500.0, user: User.new)
      expect(holding).not_to be_valid
    end

    it 'is not valid with negative average_buy_price' do
      holding = Holding.new(stock_name: 'AAPL', total_shares_owned: 10, average_buy_price: -150.0, total_value: 1500.0, user: User.new)
      expect(holding).not_to be_valid
    end

    it 'is not valid with negative total_value' do
      holding = Holding.new(stock_name: 'AAPL', total_shares_owned: 10, average_buy_price: 150.0, total_value: -1500.0, user: User.new)
      expect(holding).not_to be_valid
    end
  end
end