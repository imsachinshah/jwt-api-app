require 'rails_helper'

RSpec.describe EmailOtp, type: :model do
  describe "email_otp" do
    let!(:user) { FactoryBot.create(:user) }
    let!(:email_otp) {FactoryBot.create(:email_otp, user_id: user.id, email: user.email)}

    context "association" do
      it { should belong_to(:user) }
    end

    context "validation" do
      it {should validate_presence_of :email}
    end
  end
end
