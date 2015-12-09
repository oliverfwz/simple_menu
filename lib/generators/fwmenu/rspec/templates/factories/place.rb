FactoryGirl.define do
  factory :place do
  	sequence(:title) 	{ |n| "Aquarium and pond services #{n}" }
    description 			'Aquarium and pond services and description'
  end
end