FactoryGirl.define do
  factory :position do
  	sequence(:title) 	{ |n| "position#{n}" }
  end
end