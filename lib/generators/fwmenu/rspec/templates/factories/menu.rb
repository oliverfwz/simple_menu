FactoryGirl.define do
  factory :menu do
  	sequence(:title) 		{ |n| "Menu #{n}" }
  	sequence(:position) { |n| "position#{n}" }
    description 				'Aquarium and pond services and description'
  end
end