class AuthenticationController < ApplicationController
	include JsonWebToken
	skip_before_action :authenticate_request

	def login
		@user = User.find_by_email(params[:email])
		if (@user&.authenticate(params[:password]))
			if @user.activated?
				token = Jwt.jwt_encode({user_id: @user.id}, 7.days.from_now)
				render json: {token: token}, status: :ok
			else
				render json: {error: "First verify account by OTP for login"}, status: :bad_request
			end
		else
			render json: {error: "Unauthorized"}, status: :unauthorized
		end
	end
end
