require 'rails/generators/active_record'

class DeviseActivity::MigrationGenerator < ::Rails::Generators::Base
  include Rails::Generators::Migration
  source_root File.expand_path('../templates', __FILE__)
  # argument :table, :type => :string, :default => "application"
  desc 'Generate migration file required for devise_activity'

  def install
    migration_template 'migration.rb', "db/migrate/create_devise_activities_tables.rb"
  end

  def sessions_table_name
    DeviseActivity.configuration.sessions_table_name
  end

  def navigations_table_name
    DeviseActivity.configuration.navigations_table_name
  end

  def devise_activity_model
    DeviseActivity.configuration.devise_model_name
  end

  def self.next_migration_number(dirname)
    ActiveRecord::Generators::Base.next_migration_number(dirname)
  end
end
