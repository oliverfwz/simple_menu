require 'rails_helper'

RSpec.describe Category, type: :model do
	context 'Validation' do
		it { should validate_presence_of :title }
		it { should validate_presence_of :description }
		it { should validate_uniqueness_of :slug }
	end

	context 'Association' do
		it { should have_many :articles }
	end
end
