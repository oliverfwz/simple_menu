require "generator_spec"
require_relative "../../../../../lib/generators/fwcontent/install/install_generator.rb"

describe Fwcontent::Generators::InstallGenerator, type: :generator do
  destination File.expand_path("../../tmp", __FILE__)
  arguments %w(place)

  before(:all) do
    prepare_destination
    run_generator
  end

  it "creates a place model" do
    assert_file "app/models/place.rb"
  end

  it "creates a position model" do
    assert_file "app/models/position.rb"
  end

  it "creates a get_content_for view" do
  	assert_file "app/views/_get_content_for.html.slim"
  end

  it "creates a places table" do
  	assert_file "db/migrate/#{Time.now.utc.strftime("%Y%m%d%H%M%S").to_s}_create_places.rb"
  end

  it "creates a positions table" do
  	assert_file "db/migrate/#{(Time.now.utc.strftime("%Y%m%d%H%M%S").to_i + 1).to_s}_create_positions.rb"
  end
end