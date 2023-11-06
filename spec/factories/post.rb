FactoryBot.define do
	factory :post do
		title {Faker::Name.first_name}
		desc {Faker::Lorem.paragraph(sentence_count: 2)}
	end
end