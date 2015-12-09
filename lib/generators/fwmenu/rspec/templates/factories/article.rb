FactoryGirl.define do
	factory :article do
		sequence(:title) 	{ |n| "Aquarium and pond services #{n}" }
		description 			'Aquarium and pond services and description'
		category_id 			{ create(:category).id }
	end
end