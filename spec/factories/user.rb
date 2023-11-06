FactoryBot.define do

	factory :user do
		name {Faker::Name.first_name}
		email {Faker::Internet.email}
		sequence(:username) {|u| "username#{u}"}
		country_code {"91"}
		phone_number { "7999498437" }
		password {"123456"}
	end
end