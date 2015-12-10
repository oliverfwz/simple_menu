require "generator_spec"
require_relative "../../../../../lib/generators/simple_menu/install/install_generator.rb"

describe SimpleMenu::Generators::InstallGenerator, type: :generator do
  destination File.expand_path("../../tmp", __FILE__)
  arguments %w(menu)

  before(:all) do
    prepare_destination
    run_generator
  end

  it "creates a menu model" do
    assert_file "app/models/menu.rb"
  end

  it "creates a menu item model" do
    assert_file "app/models/menu_item.rb"
  end

  it "creates a position model" do
    assert_file "app/models/position.rb"
  end

  it "creates a menus view" do
    assert_file "app/views/_menus.html.slim"
  end

  it "creates a sub_menu view" do
    assert_file "app/views/_sub_menu.html.slim"
  end

  it "creates a menus table" do
    assert_file "db/migrate/#{Time.now.utc.strftime("%Y%m%d%H%M%S").to_s}_create_menus.rb"
  end

  it "creates a menu_items table" do
    assert_file "db/migrate/#{(Time.now.utc.strftime("%Y%m%d%H%M%S").to_i + 1).to_s}_create_menu_items.rb"
  end

  it "creates a reference menu items to menu item" do
    assert_file "db/migrate/#{(Time.now.utc.strftime("%Y%m%d%H%M%S").to_i + 2).to_s}_add_reference_menu_items_to_menu_item.rb"
  end

  it "creates a positions table" do
    assert_file "db/migrate/#{(Time.now.utc.strftime("%Y%m%d%H%M%S").to_i + 3).to_s}_create_positions.rb"
  end
end