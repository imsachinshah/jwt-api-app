require 'rails_helper'
require 'shoulda/matchers'

RSpec.describe Post, type: :model do
	
	describe "post" do
		let!(:user) {FactoryBot.create(:user)}
		let!(:post) {FactoryBot.create(:post, user_id: user.id)}	

		context "associations" do
			it {should belong_to(:user)}
		end	

		context "validattions" do
			it {should validate_presence_of :title}
			it {should validate_presence_of :desc}
		end
	end
end