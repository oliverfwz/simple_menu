require 'spec_helper'

describe "MenuHelper", type: :generator do
  it 'should have get_menus_for function' do
    assert_file "./app/helpers/menu_helper.rb" do |helper|
      assert_instance_method :get_menus_for, helper do |get_menus_for|
        assert_match(/Menu\.includes/, get_menus_for)
      end
    end
  end
end

describe "PlaceHelper", type: :generator do
  it 'should have get_content_for function' do
    assert_file "./app/helpers/place_helper.rb" do |helper|
      assert_instance_method :get_content_for, helper do |get_content_for|
        assert_match(/Place\.where/, get_content_for)
      end
    end
  end
end