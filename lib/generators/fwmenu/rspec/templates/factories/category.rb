FactoryGirl.define do
  factory :category do
  	sequence(:title) 	{ |n| "Aquarium and pond services #{n}" }
    description 			'Aquarium and pond services and description'
  end
end