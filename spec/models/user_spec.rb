require 'rails_helper'

RSpec.describe User, type: :model do
  let(:valid_attributes) do
    {
      name: "jen",
      email: "user@mail.com",
      password: "pass123",
      password_confirmation: "pass123",
      confirmed_at: Time.current
    }
  end

  it "is valid with valid attributes" do
    user = User.new(valid_attributes)
    expect(user).to be_valid
  end

  it "is not valid without an email" do
    user = User.new(valid_attributes.merge(email: nil))
    expect(user).not_to be_valid
  end

  it "is not valid with mismatched password confirmation" do
    user = User.new(valid_attributes.merge(password_confirmation: "wrongpass"))
    expect(user).not_to be_valid
  end

  it "is not valid without a password" do
    user = User.new(valid_attributes.merge(password: nil))
    expect(user).not_to be_valid
  end

  it "is not confirmed by default" do
    user = User.new(valid_attributes.except(:confirmed_at))
    expect(user.confirmed?).to be_falsey
  end

  context "when saving a duplicate email" do
    before do
      User.create!(valid_attributes)
    end

    it "is not valid with the same email" do
      duplicate_user = User.new(valid_attributes)
      expect(duplicate_user).not_to be_valid
    end
  end
end
