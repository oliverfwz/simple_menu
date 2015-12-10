
require "generator_spec"
require_relative "../../../../../lib/generators/simple_menu/rspec/rspec_generator.rb"

describe SimpleMenu::Generators::RspecGenerator, type: :generator do
  destination File.expand_path("../../../../../../tmp", __FILE__)

  before(:all) do
    prepare_destination
    run_generator
  end

  it "creates a menu factory" do
    assert_file "spec/factories/menu.rb"
  end

  it "creates a menu_item factory" do
    assert_file "spec/factories/menu_item.rb"
  end

  it "creates a position factory" do
    assert_file "spec/factories/position.rb"
  end

  it "creates a menu model spec" do
    assert_file "spec/models/menu_spec.rb"
  end

  it "creates a menu_item model spec" do
    assert_file "spec/models/menu_item_spec.rb"
  end

  it "creates a position model spec" do
    assert_file "spec/models/position_spec.rb"
  end
end