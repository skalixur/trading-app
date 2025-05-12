require 'rails_helper'

RSpec.describe "Holdings", type: :request do
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

  let!(:holding) do
    Holding.create!(
      user: user,
      stock_name: "AAPL",
      total_shares_owned: 10,
      average_buy_price: 150,
      total_value: 1500
    )
  end

  before do
    sign_in user, scope: :user
  end

  describe "GET /holdings" do
    it 'returns a success response' do
      get '/holdings'
      expect(response).to have_http_status(200)
    end
  end

  describe "GET /holdings/:id" do
    it 'returns a success response for a specific holding' do
      get "/holdings/#{holding.id}"
      expect(response).to have_http_status(200)
    end
  end

  describe "POST /holdings" do
    it 'creates a new holding with valid params' do
      post '/holdings', params: { holding: {
        user_id: user.id,
        stock_name: "GOOGL",
        total_shares_owned: 5,
        average_buy_price: 2800,
        total_value: 14000
      } }
      expect(response).to have_http_status(302)
    end
  end

  describe "PATCH /holdings/:id" do
    it 'updates an existing holding with valid params' do
      patch "/holdings/#{holding.id}", params: { holding: {
        total_shares_owned: 15,
        total_value: 2250
      } }
      expect(response).to have_http_status(302)
      holding.reload
      expect(holding.total_shares_owned).to eq(15)
      expect(holding.total_value).to eq(2250)
    end
  end

  describe "DELETE /holdings/:id" do
    it 'deletes an existing holding' do
      delete "/holdings/#{holding.id}"
      expect(response).to have_http_status(302)
      expect(Holding.exists?(holding.id)).to be_falsey
    end
  end
end
