require 'rails/generators/migration'
require 'bundler'

module Fwmenu
  module Generators
    class RspecGenerator < ::Rails::Generators::Base
      include Rails::Generators::Migration
      source_root File.expand_path('../templates', __FILE__)
      def copy_initializer_file
        copy_file "factories/category.rb", "spec/factories/category.rb"
        copy_file "factories/article.rb", "spec/factories/article.rb"
        copy_file "factories/menu.rb", "spec/factories/menu.rb"
        copy_file "factories/menu_item.rb", "spec/factories/menu_item.rb"
        copy_file "factories/place.rb", "spec/factories/place.rb"
        copy_file "factories/position.rb", "spec/factories/position.rb"

        copy_file "models/category_spec.rb", "spec/models/category_spec.rb"
        copy_file "models/article_spec.rb", "spec/models/article_spec.rb"
        copy_file "models/menu_spec.rb", "spec/models/menu_spec.rb"
        copy_file "models/menu_item_spec.rb", "spec/models/menu_item_spec.rb"
        copy_file "models/place_spec.rb", "spec/models/place_spec.rb"
        copy_file "models/position_spec.rb", "spec/models/position_spec.rb"

        copy_file "controllers/articles_controller_spec.rb", "spec/controllers/articles_controller_spec.rb"
        copy_file "controllers/categories_controller_spec.rb", "spec/controllers/categories_controller_spec.rb"
      end
    end
  end
end