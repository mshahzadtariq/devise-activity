module DeviseActivity
  class Configuration
    attr_accessor :sessions_table_name,
                  :navigations_table_name,
                  :devise_model_name,
                  :request_formats

    def initialize
      @sessions_table_name = 'sessions'
      @navigations_table_name = 'navigations'
      @devise_model_name = 'user'
      @request_formats = [:html, :pdf, :json, :xml]
      add_warden_hooks
    end

    def add_warden_hooks
      Devise.setup do |c|

        Warden::Manager.after_authentication do |record, auth, opts|
          if record and record.class == DeviseActivity.configuration.devise_model_name.classify.constantize
            begin
              Session.close_all_previous_sessions(record)
              Session.start_new_session(record)
            rescue
              puts "Something went wrong"
            end
          end
        end

        Warden::Manager.before_logout do |record, _warden, _options|
          if record and record.class == DeviseActivity.configuration.devise_model_name.classify.constantize
            Session.close_all_previous_sessions(record) rescue nil
          end
        end

      end
    end
  end
end