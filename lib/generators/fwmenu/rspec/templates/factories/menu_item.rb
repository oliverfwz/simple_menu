FactoryGirl.define do
  factory :menu_item do
  	sequence(:title) { |n| "Menu Item #{n}" }
  	menu_id 		 		 { create(:menu).id }
  	internal_link		 false
  	link 						 "http://google.com"
  end
end