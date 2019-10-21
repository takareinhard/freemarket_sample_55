require 'rails_helper'
describe User do
  describe '#create' do
    it "is invalid without a email" do
      user = User.new(email: "", encrypted_password: "00000000", earnings: "100", points: "100", card_token: "100")
      user.valid?
      expect(user.errors[:email]).to include("can't be blank")
    end
  end
end