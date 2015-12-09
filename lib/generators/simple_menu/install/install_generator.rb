require 'rails/generators/migration'
require 'bundler'

module SimpleMenu
  module Generators
    class InstallGenerator < ::Rails::Generators::Base
      include Rails::Generators::Migration
      source_root File.expand_path('../templates', __FILE__)
      desc "add the migrations"

      def self.next_migration_number(path)
        unless @prev_migration_nr
          @prev_migration_nr = Time.now.utc.strftime("%Y%m%d%H%M%S").to_i
        else
          @prev_migration_nr += 1
        end
        @prev_migration_nr.to_s
      end

      def copy_migrations
        migration_template "migration/create_menus.rb", "db/migrate/create_menus.rb"
        migration_template "migration/create_menu_items.rb", "db/migrate/create_menu_items.rb"
        migration_template "migration/add_reference_menu_items_to_menu_item.rb", "db/migrate/add_reference_menu_items_to_menu_item.rb"
        migration_template "migration/create_positions.rb", "db/migrate/create_positions.rb"
      end

      def copy_initializer_file
        active = Bundler.load.specs.map { |spec| spec.name }

        copy_file "models/menu.rb", "app/models/menu.rb"
        copy_file "models/menu_item.rb", "app/models/menu_item.rb"
        copy_file "models/position.rb", "app/models/position.rb"

        copy_file "views/_menus.html.slim", "app/views/simple_menu/_menus.html.slim"
        copy_file "views/_sub_menu.html.slim", "app/views/simple_menu/_sub_menu.html.slim"
      end
    end
  end
end