module DeviseActivity
  class Configuration
    attr_accessor :sessions_table_name,
                  :navigations_table_name,
                  :devise_model_name,
                  :sign_in_controller_name,
                  :sign_in_action_name,
                  :sign_out_controller_name,
                  :sign_out_action_name

    def initialize
      @sessions_table_name = 'sessions'
      @navigations_table_name = 'navigations'
      @sign_in_controller_name = 'sessions'
      @sign_in_action_name = 'create'
      @sign_out_controller_name = 'sessions'
      @sign_out_action_name = 'destroy'
    end
  end
end