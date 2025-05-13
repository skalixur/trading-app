require 'rails_helper'

RSpec.describe "Users", type: :request do
  describe "POST /users" do
    it "registers a new user with valid params" do
      post user_registration_path, params: {
        user: {
          name: "jennie",
          email: "jennie@mail.com",
          password: "pass123",
          password_confirmation: "pass123"
        }
      }

      expect(response).to redirect_to(root_path) # or your after_sign_up_path
      follow_redirect!
      # expect(response.body).to include("Welcome")
    end

    it "fails registration with invalid email" do
      post user_registration_path, params: {
        user: {
          email: "invalid",
          password: "password123",
          password_confirmation: "password123"
        }
      }

      expect(response.body).to include("Email is invalid")
    end
  end

  describe "POST /users/sign_in" do
    before do
      User.create!(
        name: "jennie",
        email: "login@example.com",
        password: "password123",
        password_confirmation: "password123",
        confirmed_at: Time.current # for Devise confirmable
      )
    end

    it "logs in a user with valid credentials" do
      post user_session_path, params: {
        user: {
          email: "login@example.com",
          password: "password123"
        }
      }

      expect(response).to redirect_to(root_path) # or your after_sign_in_path
      follow_redirect!
      expect(response.body).to include("Signed in successfully")
    end

    it "rejects invalid login" do
      post user_session_path, params: {
        user: {
          email: "login@example.com",
          password: "wrongpass"
        }
      }

      expect(response.body).to include("Invalid Email or password.")
    end
  end
end