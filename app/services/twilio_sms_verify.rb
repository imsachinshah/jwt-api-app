require "twilio-ruby"

module TwilioSmsVerify
	class TwilioOtp
		TWILIO_ACCOUNT_SID = ENV["TWILIO_ACCOUNT_SID"]
		TWILIO_AUTH_TOKEN = ENV["TWILIO_AUTH_TOKEN"]

		def initialize(otp, user)
			@otp = otp,
			@to_number = "+#{user.country_code}#{user.phone_number}"
		end 

		def send_otp 
			@client = Twilio::REST::Client.new(TWILIO_ACCOUNT_SID, TWILIO_AUTH_TOKEN)
			message = @client.messages.create(
				body: "OTP for account verification is #{@otp}",
				from: "+16414274366",
				to: @to_number	
			)
			puts message.sid
		end

		def call
			send_otp
		end
	end 
end