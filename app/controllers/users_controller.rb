class UsersController < ApplicationController
	skip_before_action :authenticate_request, only: [:create]
	# before_action :set_user, only: [:show, :update, :destroy]
	include TwilioSmsVerify

	def index
		@users = User.all 
		if @users
			render json: UserSerializer.new(@users).serializable_hash, status: :ok
		else
			render json: @users.errors, status: :bad_request
		end
	end

	def create
		@user = User.new(user_params)

		if @user.save
			@otp_token = @user.create_otp
			@user_token = Jwt.jwt_encode({user_id: @user.id}, 7.days.from_now)
			phone_twilio_otp(@user)
			render json: UserSerializer.new(@user, meta: {otp_token: @otp_token, user_token: @user_token}).serializable_hash, status: :created
		else
			render json: @user.errors, status: :unprocessable_entity
		end
	end

	def show
		render json: UserSerializer.new(@current_user).serializable_hash, status: :ok
	end	

	def update
		if @current_user.update(user_params)
			render json: UserSerializer.new(@current_user).serializable_hash, status: :ok
		else
			render json: @current_user.errors, status: :unprocessable_entity
		end
	end

	def destroy
	  @current_user.destroy
		render json: {message: "#{@current_user.name} deleted successfully"}, status: :ok
	end


	private
		def user_params
			params.require(:user).permit(:name, :email, :password, :username, :avatar, :country_code, :phone_number)
		end

		def phone_twilio_otp(user)
			otp_token = Jwt.jwt_decode(@otp_token)
			otp = EmailOtp.find(otp_token[:otp_id])
			TwilioOtp.new(otp.pin, user).call
		end

end
