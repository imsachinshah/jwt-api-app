require 'rails_helper'
require 'shoulda/matchers'

RSpec.describe Notification, type: :model do
	describe "notification" do
		let!(:user) { FactoryBot.create(:user) }
		let!(:post) { FactoryBot.create(:post, user_id: user.id) }
		let!(:notification) { FactoryBot.create(:notification, user_id: user.id, post_id: post.id) }

		context "associations" do
			it { should belong_to(:user) }
			it {should belong_to(:post) }
		end
	end
end