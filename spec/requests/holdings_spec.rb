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

  describe "GET /holdings" do
    it 'redirects unauthenticated users' do
      get '/holdings'
      expect(response).to redirect_to(new_user_session_path)
    end
  end

  context "when logged in" do
    before do
      sign_in user, scope: :user
    end

    it 'returns a success response' do
      get '/holdings'
      expect(response).to have_http_status(200)
    end

    it 'only returns holdings belonging to the current user' do
      other_user = User.create!(
        name: "Jennie",
        email: "jennie@mail.com",
        password: "1234567",
        password_confirmation: "1234567",
        balance: 10000,
        is_approved: true,
        is_admin: false,
        confirmed_at: Time.now
      )

      holding1 = Holding.create!(
        user: user,
        stock_name: "NFLX",
        total_shares_owned: 4.0,
        average_buy_price: 1124.26,
        total_value: 4497.04
      )

      holding2 = Holding.create!(
        user: other_user,
        stock_name: "TSLA",
        total_shares_owned: 4.0,
        average_buy_price: 321.99,
        total_value: 1287.96
      )

      get '/holdings'
      expect(assigns(:holdings)).to contain_exactly(holding1)
      expect(assigns(:holdings)).not_to include(holding2)
    end
  end
end
