class User < ApplicationRecord
	include JsonWebToken
	has_secure_password
	has_one_attached :avatar
	has_many :posts, dependent: :destroy
	has_many :notifications
	has_many :email_otps

	validates :name, presence: true
	validates :password, presence: true, on: :create
	validates :email, presence: true, uniqueness: true
	validates :username, presence: true, uniqueness: true
	# validates :activated

	def create_otp
		otp = rand(1000..9999)
		otp = EmailOtp.create(pin: otp, email: self.email, user_id: self.id)
		otp_token = Jwt.jwt_encode(user_id: self.id, otp_id: otp.id)
		return otp_token
	end
end
