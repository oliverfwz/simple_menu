require 'rails_helper'

RSpec.describe MenuItem, type: :model do
  let!(:menu_item)      { create(:menu_item, title: "Update Menu Item 1") }
  let!(:sub_menu_item)  { create(:menu_item, menu_item_id: menu_item.id, menu_id: menu_item.menu_id) }

  context 'Validation' do
    it { is_expected.to validate_presence_of :title }
    it { is_expected.to validate_presence_of :menu }

    context 'Association' do
      it { is_expected.to have_many :children }
      it { is_expected.to belong_to :menu }
      it { is_expected.to belong_to :parent }
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

  context '#update_sort_tree' do
    it 'update column sort_tree to sort' do
      expect(menu_item.sort_tree).to eq(
          menu_item.format_sort_tree(menu_item.id)
        )

      expect(sub_menu_item.sort_tree).to eq(
          menu_item.format_sort_tree(menu_item.id) + '.' + sub_menu_item.format_sort_tree(sub_menu_item.id)
        )
    end
  end

  context '#parent_ids_format_sort_tree' do
    it 'return parent_ids format sort tree' do
      expect(sub_menu_item.parent_ids_format_sort_tree([menu_item.format_sort_tree(sub_menu_item.id)], sub_menu_item)).to eq(
          [menu_item.format_sort_tree(sub_menu_item.id), menu_item.format_sort_tree(menu_item.id)]
        )
    end
  end

  context '#format_sort_tree' do
    it 'return result' do
      expect(menu_item.format_sort_tree(23)).to eq ("0023")
    end
  end

  context '#child_ids' do
    it 'return result' do
      expect(menu_item.child_ids).to eq([menu_item.id, sub_menu_item.id])
    end
  end

  context '#get_parents' do
    it 'return result' do
      arr = sub_menu_item.get_parents
      expect(arr[0][1]).to eq(menu_item.id)
    end
  end
end
