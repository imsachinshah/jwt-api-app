require 'rails_helper'
include JsonWebToken

RSpec.describe "EmailOtps", type: :request do

	let!(:user) {FactoryBot.create(:user)}
	let!(:new_token) {Jwt.jwt_encode({user_id: user.id}, 7.days.from_now)}
	let!(:token) do
		{ "Authorization": "#{new_token}" }
	end
	let!(:email_otp) {FactoryBot.create(:email_otp, user_id: user.id, email: user.email)}
	let!(:otp_token) {Jwt.jwt_encode({user_id: user.id, otp_id: email_otp.id}, 10.minutes.from_now)}

	let!(:valid_params) {{
		"otp": email_otp.pin,
		"otp_token": "#{otp_token}"
	}}


	describe "POST Verify OTP" do

		it 'will Verify User with otp' do
			post '/verify', params: valid_params, headers: token
			expect(response).to have_http_status(:ok)
		end
	end
end