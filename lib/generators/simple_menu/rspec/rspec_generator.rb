require 'rails/generators/migration'
require 'bundler'

module SimpleMenu
  module Generators
    class RspecGenerator < ::Rails::Generators::Base
      include Rails::Generators::Migration
      source_root File.expand_path('../templates', __FILE__)
      def copy_initializer_file
        copy_file "factories/menu.rb", "spec/factories/menu.rb"
        copy_file "factories/menu_item.rb", "spec/factories/menu_item.rb"
        copy_file "factories/position.rb", "spec/factories/position.rb"

        copy_file "models/menu_spec.rb", "spec/models/menu_spec.rb"
        copy_file "models/menu_item_spec.rb", "spec/models/menu_item_spec.rb"
        copy_file "models/position_spec.rb", "spec/models/position_spec.rb"
      end
    end
  end
end