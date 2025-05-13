require 'rails_helper'

RSpec.describe Transaction, type: :model do
  # pending "add some examples to (or delete) #{__FILE__}"
  context 'validations' do
   let!(:user) do
      User.create!(
        name: "Nela",
        email: "nela@mail.com",
        password: "1234567",
        password_confirmation: "1234567",
        balance: 10000,
        is_approved: true,
        is_admin: false,
        confirmed_at: Time.now
      )
    end

    it 'is valid with required attributes' do
      transaction = Transaction.new(
        stock_name: "MSFT",

        quantity: 2,
        stock_price_per_share: 433,
        total_price: 866,
        transaction_type: "Buy",
        user: user
      )
      expect(transaction).to be_valid
    end

    it 'is invalid without a stock_name' do
      transaction = Transaction.new(
        stock_name: nil,
        quantity: 2,
        stock_price_per_share: 433,
        total_price: 866,
        transaction_type: "Buy",
        user: user
      )
      expect(transaction).not_to be_valid
    end

    it 'is invalid without transaction_type' do
      transaction = Transaction.new(
        stock_name: nil,
        quantity: 2,
        stock_price_per_share: 433,
        total_price: 866,
        transaction_type: nil,
        user: user
      )
      expect(transaction).not_to be_valid
    end

    it 'is invalid when quantity is less than or equal to 0' do
      transaction = Transaction.new(
        stock_name: nil,
        quantity: 0,
        stock_price_per_share: 433,
        total_price: 866,
        transaction_type: nil,
        user: user
      )
      expect(transaction).not_to be_valid
    end

    it 'is invalid without stock_price_per_share' do
      transaction = Transaction.new(
        stock_name: nil,
        quantity: 2,
        stock_price_per_share: nil,
        total_price: 866,
        transaction_type: "Buy",
        user: user
      )
      expect(transaction).not_to be_valid
    end

    it 'is invalid when total_price is less than or equal to 0' do
      transaction = Transaction.new(
        stock_name: nil,
        quantity: 2,
        stock_price_per_share: 433,
        total_price: 0,
        transaction_type: "Buy",
        user: user
      )
      expect(transaction).not_to be_valid
    end
  end
end
