require "jwt"

module JsonWebToken
	class Jwt
		class << self
			SECRET_KEY = Rails.application.secret_key_base
			
			def jwt_encode(payload, exp)
				payload[:exp] = exp.to_i
				JWT.encode(payload, SECRET_KEY)
			end

			def jwt_decode(token)
				decoded = JWT.decode(token, SECRET_KEY)[0]
				HashWithIndifferentAccess.new(decoded)
			end
		end
	end
end