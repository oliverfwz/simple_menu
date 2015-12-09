require 'rails_helper'

RSpec.describe Menu, type: :model do
  context 'Validation' do
    it { is_expected.to validate_presence_of :title }
    it { is_expected.to validate_presence_of :position }

    context 'Association' do
      it { is_expected.to have_many :menu_items }
    end
  end
end
