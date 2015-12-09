require "generator_spec"
require_relative "../../../../../lib/generators/fwmenu/install/install_generator.rb"

describe Fwmenu::Generators::InstallGenerator, type: :generator do
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

  it "creates a article model" do
    assert_file "app/models/article.rb"
  end

  it "creates a category model" do
    assert_file "app/models/category.rb"
  end

  it "creates a get_menu_for view" do
    assert_file "app/views/_get_menu_for.html.slim"
  end

  it "creates a menu view" do
    assert_file "app/views/_menu.html.slim"
  end

  it "creates a get_submenu_for view" do
    assert_file "app/views/_get_submenu_for.html.slim"
  end

  it "creates a show.html.slim view to article" do
    assert_file "app/views/articles/show.html.slim"
  end

  it "creates a article.html.slim view to article" do
    assert_file "app/views/articles/show/article.html.slim"
  end

  it "creates a latest.html.slim view to article" do
    assert_file "app/views/articles/show/latest.html.slim"
  end

  it "creates a show.html.slim view to category" do
    assert_file "app/views/categories/show.html.slim"
  end

  it "creates a article.html.slim view to category" do
    assert_file "app/views/categories/show/article.html.slim"
  end

  it "creates a latest.html.slim view to category" do
    assert_file "app/views/categories/show/latest.html.slim"
  end

  it "creates a article controller" do
    assert_file "app/controllers/articles_controller.rb"
  end

  it "creates a categories controller" do
    assert_file "app/controllers/categories_controller.rb"
  end

  it "creates a menus table" do
    assert_file "db/migrate/#{Time.now.utc.strftime("%Y%m%d%H%M%S").to_s}_create_menus.rb"
  end

  it "creates a menu_items table" do
    assert_file "db/migrate/#{(Time.now.utc.strftime("%Y%m%d%H%M%S").to_i + 1).to_s}_create_menu_items.rb"
  end

  it "creates a articles table" do
    assert_file "db/migrate/#{(Time.now.utc.strftime("%Y%m%d%H%M%S").to_i + 2).to_s}_create_articles.rb"
  end

  it "creates a categories table" do
    assert_file "db/migrate/#{(Time.now.utc.strftime("%Y%m%d%H%M%S").to_i + 3).to_s}_create_categories.rb"
  end

  it "creates a reference menu items to menu item" do
    assert_file "db/migrate/#{(Time.now.utc.strftime("%Y%m%d%H%M%S").to_i + 4).to_s}_add_reference_menu_items_to_menu_item.rb"
  end

  it "creates a reference menu items to article" do
    assert_file "db/migrate/#{(Time.now.utc.strftime("%Y%m%d%H%M%S").to_i + 5).to_s}_add_reference_menu_items_to_article.rb"
  end

  it "creates a reference menu items to category" do
    assert_file "db/migrate/#{(Time.now.utc.strftime("%Y%m%d%H%M%S").to_i + 6).to_s}_add_reference_menu_items_to_category.rb"
  end

  it "creates a reference articles to category" do
    assert_file "db/migrate/#{(Time.now.utc.strftime("%Y%m%d%H%M%S").to_i + 7).to_s}_add_reference_articles_to_category.rb"
  end
end