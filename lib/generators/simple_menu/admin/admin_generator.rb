require 'rails/generators/migration'
require 'bundler'

module SimpleMenu
  module Generators
    class AdminGenerator < ::Rails::Generators::Base
      include Rails::Generators::Migration
      source_root File.expand_path('../templates', __FILE__)
      desc "add the migrations"

      def copy_initializer_file
        active = Bundler.load.specs.map { |spec| spec.name }
        if active.include? "activeadmin"
          template "activeadmin/menu.rb", "app/admin/menu.rb"
          template "activeadmin/menu_item.rb", "app/admin/menu_item.rb"
          template "activeadmin/position.rb", "app/admin/position.rb"
        end
      end
    end
  end
end