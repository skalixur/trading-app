require 'rails_helper'

RSpec.describe User, type: :model do
  # pending "add some examples to (or delete) #{__FILE__}"
  context 'validations' do
    it 'does not allow creation of user with invalid attribute values' do
      user = User.new(name: "jen", email: "mail@mail.com", password: nil)
      expect(user).not_to be_valid
    end
  end
end
