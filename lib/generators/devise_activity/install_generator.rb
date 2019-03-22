module DeviseActivity
  module Generators
    class InstallGenerator < Rails::Generators::Base
      source_root File.expand_path("../templates", __FILE__)
      desc "Creates DeviseActivity initializer for your application"

      def copy_initializer
        template "devise_activity_initializer.rb", "config/initializers/devise_activity.rb"

        puts "Install complete! Truly Outrageous!"
      end
    end
  end
end
