require 'rails_helper'
require 'shoulda/matchers'

RSpec.describe User, type: :model do

  describe "user" do
    let!(:user) {FactoryBot.create(:user)}

    context "associations" do
      it {should have_many(:posts).dependent(:destroy) }
    end

    context "validations" do
      it {should validate_presence_of :name}
      it {should validate_presence_of :email}
      it {should validate_presence_of :username}
      it {should validate_presence_of :password}
      it {should have_secure_password :password}
      it {should validate_presence_of :country_code}
      it {should validate_presence_of :phone_number}
      it {should validate_numericality_of(:phone_number) }
      it {expect(user.phone_number.to_s.length).to eq(10) }

      context "uniqueness" do
        before {create(:user)}
        it {should validate_uniqueness_of(:email)}
        it {should validate_uniqueness_of(:username)}
      end  
    end
  end

end
