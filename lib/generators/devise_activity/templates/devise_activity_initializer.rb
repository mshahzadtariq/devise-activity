require 'devise_activity'
require 'securerandom'

DeviseActivity.configure do |config|
  config.sessions_table_name = 'sessions'
  config.navigations_table_name = 'navigations'
  config.devise_model_name = 'user'

  config.sign_in_controller_name = 'sessions'
  config.sign_in_action_name = 'create'
  config.sign_out_controller_name = 'sessions'
  config.sign_out_action_name = 'destroy'

end