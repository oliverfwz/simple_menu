require 'rails/generators/migration'

module Fwcontent
  module Generators
    class AdminGenerator < ::Rails::Generators::NamedBase
      include Rails::Generators::Migration
      source_root File.expand_path('../templates', __FILE__)
      

      def copy_initializer_file
        active = Bundler.load.specs.map { |spec| spec.name }
        if active.include? "activeadmin"
          template "activeadmin/content.rb", "app/admin/#{file_name}.rb"
          template "activeadmin/position.rb", "app/admin/position.rb"
        end
        if active.include? "rails_admin"
          template "rails_admin/model/content.rb", "app/models/#{file_name}.rb"
        end
      end
    end
  end
end