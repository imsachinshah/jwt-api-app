require 'rails_helper'

RSpec.describe CheckStatusJob, type: :job do
	let!(:user) {FactoryBot.create(:user)}
	let!(:posts) {FactoryBot.create_list(:post, 5, user_id: user.id)}

	subject(:job) {described_class.perform_later()}

	after do
		have_enqueued_jobs
	end

	it "perform of the job" do
		expect {job.perform_now}.to change {Post.where(status: true).count}.by(5)
	end

end