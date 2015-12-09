require 'rails_helper'

RSpec.describe Menu, type: :model do
	context 'Validation' do
		it { should validate_presence_of :title }
		it { should validate_presence_of :position }

		context 'Association' do
			it { should have_many :menu_items }
		end
	end

	context 'Render menu' do
		let!(:menu) 			{ create(:menu) }

		it 'create a place after create menu' do
			expect(Place.all.size).to eq 1
		end
	end
end
