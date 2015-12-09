require "generator_spec"
require_relative "../../../../../lib/generators/fwmenu/rspec/rspec_generator.rb"

describe Fwmenu::Generators::RspecGenerator, type: :generator do
  destination File.expand_path("../../../../../../tmp", __FILE__)

  before(:all) do
    prepare_destination
    run_generator
  end

  it "creates a category factory" do
    assert_file "spec/factories/category.rb"
  end

  it "creates a article factory" do
    assert_file "spec/factories/article.rb"
  end

  it "creates a menu factory" do
    assert_file "spec/factories/menu.rb"
  end

  it "creates a menu_item factory" do
    assert_file "spec/factories/menu_item.rb"
  end

  it "creates a place factory" do
    assert_file "spec/factories/place.rb"
  end

  it "creates a position factory" do
    assert_file "spec/factories/position.rb"
  end

  it "creates a category model spec" do
    assert_file "spec/models/category_spec.rb"
  end

  it "creates a article model spec" do
    assert_file "spec/models/article_spec.rb"
  end

  it "creates a menu model spec" do
    assert_file "spec/models/menu_spec.rb"
  end

  it "creates a menu_item model spec" do
    assert_file "spec/models/menu_item_spec.rb"
  end

  it "creates a place model spec" do
    assert_file "spec/models/place_spec.rb"
  end

  it "creates a position model spec" do
    assert_file "spec/models/position_spec.rb"
  end

  it "creates a articles controller spec" do
    assert_file "spec/controllers/articles_controller_spec.rb"
  end

  it "creates a categories controller spec" do
    assert_file "spec/controllers/categories_controller_spec.rb"
  end
end