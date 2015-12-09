require 'rails_helper'

RSpec.describe MenuItem, type: :model do
	let!(:menu_item) 			{ create(:menu_item, title: "Update Menu Item 1") }
	let!(:sub_menu_item) 	{ create(:menu_item, menu_item_id: menu_item.id, menu_id: menu_item.menu_id) }

	context 'Validation' do
		it { should validate_presence_of :title }
		it { should validate_presence_of :menu }

		context 'Association' do
			it { should have_many :menu_items }
			it { should belong_to :menu }
			it { should belong_to :menu_item }
			it { should belong_to :category }
			it { should belong_to :category }
		end	

		context 'Validation custom' do
			it 'check its menu and menu of its parent is only one' do
				item = MenuItem.new(menu_item_id: menu_item.id, menu_id: create(:menu).id)
				item.validate
				expect(item.errors.messages).to include(menu_item: ["Please select parent belong to menu group"]) 
			end

			it 'check its parent is its submenu or itself' do
				item = menu_item
				item.assign_attributes(menu_item_id: item.id)
				item.validate
				expect(item.errors.messages).to include(menu_item: ["Please don't select parent is submenu of this item or itself"]) 
			end

			it 'check its parent is its submenu or itself' do
				item = sub_menu_item
				item.assign_attributes(menu_id: create(:menu).id)
				item.validate
				expect(item.errors.messages).to include(menu: ["Please can not change menu group."]) 
			end

			context 'Internal link' do
				it 'page can not blank' do
					item = menu_item
					item.assign_attributes(internal_link: true)
					item.validate
					expect(item.errors.messages).to include(page: ["Please fill up this field"]) 
				end

				it 'article can not blank if select /articles/:id' do
					item = menu_item
					item.assign_attributes(internal_link: true, page: "/articles/:id")
					item.validate
					expect(item.errors.messages).to include(article: ["Please fill up this field"]) 
				end

				it 'category can not blank if select /categories/:id' do
					item = menu_item
					item.assign_attributes(internal_link: true, page: "/categories/:id")
					item.validate
					expect(item.errors.messages).to include(category: ["Please fill up this field"]) 
				end

				it 'show can not blank if is other component and page include :id' do
					item = menu_item
					item.assign_attributes(internal_link: true, page: "/example/:id")
					item.validate
					expect(item.errors.messages).to include(show: ["Please fill up this field"]) 
				end
			end

			context 'External link' do
				it 'check link not blank' do
					item = menu_item
					item.assign_attributes(link: "")
					item.validate
					expect(item.errors.messages).to include(link: ["Please fill up this field"]) 
				end
			end
		end
	end

	context 'Render menu' do
		it 'update a place after create menu item' do
			expect(Place.first.description).to include("Update Menu Item 1")
		end
	end
end
