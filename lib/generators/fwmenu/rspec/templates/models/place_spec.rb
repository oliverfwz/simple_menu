require 'rails_helper'

RSpec.describe Place, type: :model do
	context 'Validation' do
		it { should validate_presence_of :title }
		it { should validate_presence_of :description }
	end
end
