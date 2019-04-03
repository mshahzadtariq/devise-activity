require 'devise_activity/configuration'
require 'active_record'

module DeviseActivity

  extend ActiveSupport::Concern

  included do

    before_action :track_navigation_activity, if: Proc.new{ da_current_user.present? }

    protected

    def track_navigation_activity
      current_session = find_or_create_current_session
      Navigation.create session_id: current_session.id,
                        page_url: request.original_url,
                        controller_name: controller_name,
                        action_name: action_name
    end

    def find_or_create_current_session
      Session.current(da_current_user).present? ? Session.current(da_current_user) : Session.start_new_session(da_current_user)
    end

    def da_current_user
      self.send("current_#{DeviseActivity.configuration.devise_model_name}")
    end

  end

  class << self
    attr_accessor :configuration
  end

  def self.configure
    self.configuration ||= Configuration.new
    yield(configuration)
    # Load models after configurations
    if defined?(ActiveRecord::Base)
      require "devise_activity/extenders/session"
      require "devise_activity/extenders/navigation"
      require "devise_activity/session"
      require "devise_activity/navigation"
      require "devise_activity/stats"
      require "devise_activity/devise_model"
      ActiveRecord::Base.extend DeviseActivity::Extenders::Session
      ActiveRecord::Base.extend DeviseActivity::Extenders::Navigation
    end


  end
end
