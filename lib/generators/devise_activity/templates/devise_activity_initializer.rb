require 'devise_activity'
require 'securerandom'

DeviseActivity.configure do |config|
  config.sessions_table_name = 'sessions'
  config.navigations_table_name = 'navigations'
  config.devise_model_name = 'user'
end