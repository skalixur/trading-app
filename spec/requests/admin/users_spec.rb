require 'rails_helper'


# RSpec.describe "Users", type: :request do
#   describe "GET /admin/users" do
#     # pending "add some examples (or delete) #{__FILE__}"
#     it "returns a success response" do
#       get admin_users_path
#       expect(response).to have_http_status(200)
#     end
#   end
# end

RSpec.describe "Admin::Users", type: :request do
  include Devise::Test::IntegrationHelpers
  let!(:admin_user) {
    User.create!(
      name: "Admin User",
      email: "admin@example.com",
      password: "password",
      password_confirmation: "password",
      is_admin: true,
      is_approved: true,
      confirmed_at: Time.current
    )
  }

  let!(:managed_user) {
    User.create!(
      name: "Regular User",
      email: "user@example.com",
      password: "password",
      password_confirmation: "password",
      is_admin: false,
      is_approved: true,
      confirmed_at: Time.current
    )
  }

  before do
    sign_in admin_user # ✅ No scope needed unless you have multiple Devise models
  end

  describe "GET /admin/users" do
    it "renders the index view" do
      get admin_users_path
      expect(response).to have_http_status(:ok)
      expect(response.body).to include("Users")
    end
  end

  describe "GET /admin/users/:id/edit" do
    it "renders the edit user form" do
      get edit_admin_user_path(managed_user)
      expect(response).to have_http_status(:ok)
      expect(response.body).to include("Edit User")
    end
  end

  describe "PATCH /admin/users/:id" do
    it "updates the user" do
      patch admin_user_path(managed_user), params: {
        user: { email: "updated@example.com" }
      }

      expect(response).to redirect_to(admin_users_path)
      follow_redirect!
      expect(response.body).to include("User successfully updated").or include("User updated")
    end
  end

  describe "DELETE /admin/users/:id" do
    it "deletes the user" do
      delete admin_user_path(managed_user)
      expect(response).to redirect_to(admin_users_path)
      follow_redirect!
      expect(response.body).to include("User was successfully deleted").or include("User deleted")
    end
  end
end
