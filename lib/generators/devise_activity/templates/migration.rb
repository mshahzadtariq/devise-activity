class CreateDeviseActivitiesTables < ActiveRecord::Migration<%= [Rails::VERSION::STRING.to_f] if Rails::VERSION::MAJOR >= 5 -%>

  def change
    create_table :<%= session_activities_table_name -%> do |t|
      t.integer :<%= devise_activity_model -%>_id
      t.datetime :signed_in_at
      t.datetime :signed_out_at

      t.string :ip_address

      t.timestamps null: false
    end

    create_table :<%= session_navigations_table_name -%> do |t|
      t.integer :<%= session_activities_table_name.singularize -%>_id

      t.string :page_url

      t.string :controller_name
      t.string :action_name

      t.timestamps null: false
    end

  end
end
