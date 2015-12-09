require 'rails/generators/migration'
require 'bundler'

module Fwmenu
  module Generators
    class InstallGenerator < ::Rails::Generators::NamedBase
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
        migration_template "migration/create_menus.rb", "db/migrate/create_#{file_name}s.rb"
        migration_template "migration/create_menu_items.rb", "db/migrate/create_#{file_name}_items.rb"
        migration_template "migration/create_articles.rb", "db/migrate/create_articles.rb"
        migration_template "migration/create_categories.rb", "db/migrate/create_categories.rb"
        migration_template "migration/add_reference_menu_items_to_menu_item.rb", "db/migrate/add_reference_#{file_name}_items_to_#{file_name}_item.rb"
        migration_template "migration/add_reference_menu_items_to_article.rb", "db/migrate/add_reference_#{file_name}_items_to_article.rb"
        migration_template "migration/add_reference_menu_items_to_category.rb", "db/migrate/add_reference_#{file_name}_items_to_category.rb"
        migration_template "migration/add_reference_articles_to_category.rb", "db/migrate/add_reference_articles_to_category.rb"
      end

      def copy_initializer_file
        active = Bundler.load.specs.map { |spec| spec.name }

        template "models/menu.rb", "app/models/#{file_name}.rb"
        template "models/article.rb", "app/models/article.rb"
        template "models/category.rb", "app/models/category.rb"
        copy_file "controllers/articles_controller.rb", "app/controllers/articles_controller.rb"
        copy_file "controllers/categories_controller.rb", "app/controllers/categories_controller.rb"
        template "views/_get_menu_for.html.slim", "app/views/_get_#{file_name}_for.html.slim"
        template "views/_menu.html.slim", "app/views/_#{file_name}.html.slim"
        template "views/_get_submenu_for.html.slim", "app/views/_get_sub#{file_name}_for.html.slim"
        copy_file "views/articles/show.html.slim", "app/views/articles/show.html.slim"
        copy_file "views/articles/show/article.html.slim", "app/views/articles/show/article.html.slim"
        copy_file "views/articles/show/latest.html.slim", "app/views/articles/show/latest.html.slim"
        copy_file "views/categories/show.html.slim", "app/views/categories/show.html.slim"
        copy_file "views/categories/show/article.html.slim", "app/views/categories/show/article.html.slim"
        copy_file "views/categories/show/latest.html.slim", "app/views/categories/show/latest.html.slim"

        if active.include? "activeadmin"
          
        else
          template "models/menu_item.rb", "app/models/#{file_name}_item.rb"
        end
      end

      def setup_routes
        if ENV["RAILS_ENV"] != "test"
          route "resources :articles, only: [:show]"
          route "resources :categories, only: [:show]"
        end
      end
    end
  end
end