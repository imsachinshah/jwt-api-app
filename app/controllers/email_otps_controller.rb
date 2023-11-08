class EmailOtpsController < ApplicationController

	def verify_otp
		otp_token = Jwt.jwt_decode(params[:otp_token])
		otp = EmailOtp.find(otp_token[:otp_id])
		debugger
		if (otp.pin == params[:otp].to_i)
			@current_user.update(activated: true)
			render json: {message: "OTP is verified"}, status: :ok
		else
			render json: {error: "Wrong OTP is enterred, Please try again"}, status: :bad_request
		end
	end

end
