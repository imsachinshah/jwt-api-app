FactoryBot.define do
	factory :notification do
		heading {Faker::Name.name}
		content {Faker::Lorem.paragraph(sentence_count: 2)}
	end
end