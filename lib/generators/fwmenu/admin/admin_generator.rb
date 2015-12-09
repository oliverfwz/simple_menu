require 'rails/generators/migration'
require 'bundler'

module Fwmenu
  module Generators
    class AdminGenerator < ::Rails::Generators::NamedBase
      include Rails::Generators::Migration
      source_root File.expand_path('../templates', __FILE__)
      desc "add the migrations"

      def copy_initializer_file
        active = Bundler.load.specs.map { |spec| spec.name }
        if active.include? "activeadmin"
          template "activeadmin/model/menu_item.rb", "app/models/#{file_name}_item.rb"
          template "activeadmin/menu.rb", "app/admin/#{file_name}.rb"
          template "activeadmin/menu_item.rb", "app/admin/#{file_name}_item.rb"
          template "activeadmin/article.rb", "app/admin/article.rb"
          template "activeadmin/category.rb", "app/admin/category.rb"
        end
        if active.include? "rails_admin"
          template "rails_admin/model/menu.rb", "app/models/#{file_name}.rb"
        end
      end
    end
  end
end