FactoryBot.define do
	factory :email_otp do 
		pin {rand(1000..9999)}
	end
end