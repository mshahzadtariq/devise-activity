require 'rails/generators/active_record'

class DeviseActivity::MigrationGenerator < ::Rails::Generators::Base
  include Rails::Generators::Migration
  source_root File.expand_path('../templates', __FILE__)
  argument :table, :type => :string, :default => "application"
  desc 'Generate migration file required for devise_activity'

  def install
    migration_template 'migration.rb', "db/migrate/create_devise_activities.rb"
  end

  def session_activities_table_name
    'activities'
  end

  def session_navigations_tables_name
    'navigations'
  end

  def devise_activity_model
    'user'
  end

  def self.next_migration_number(dirname)
    ActiveRecord::Generators::Base.next_migration_number(dirname)
  end
end
