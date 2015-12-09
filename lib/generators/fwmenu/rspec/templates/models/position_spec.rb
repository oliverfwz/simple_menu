require 'rails_helper'

RSpec.describe Position, type: :model do
	context 'Validation' do
		it { should validate_presence_of :title }
	end
end
