require 'rails_helper'

RSpec.describe "Transactions", type: :request do
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

  let!(:new_transaction) { 
    Transaction.create!(
      user: user,
      stock_name: "MSFT",
      quantity: 2,
      stock_price_per_share: 433,
      total_price: 866,
      transaction_type: "Buy"
      )}

  before do
    sign_in user, scope: :user
  end

  describe "GET /transactions" do
    # pending "add some examples (or delete) #{__FILE__}"
    it 'returns a success response' do
      get '/transactions'
      expect(response).to have_http_status(200)
    end
  end

  describe "GET /transactions" do
    it 'returns a success response when getting a single record' do
      get '/transactions', params: { id: new_transaction.id }
      expect(response).to have_http_status(200)
    end
  end

  describe "POST /transactions" do
    it 'creates a new transaction with valid params' do
      post '/transactions', params: { transaction: {
      user: user,
      stock_name: "MSFT",
      quantity: 2,
      stock_price_per_share: 433,
      total_price: 866,
      transaction_type: "Buy"
      }}
      expect(response).to have_http_status(302)
    end
  end
end

