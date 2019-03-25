require 'devise_activity/configuration'
require 'active_record'

module DeviseActivity

  extend ActiveSupport::Concern

  included do

    before_action :track_navigation_activity, if: Proc.new{ da_current_user.present? }

    prepend_before_action :track_sign_out_activity, if: Proc.new{ controller_name == DeviseActivity.configuration.sign_out_controller_name and action_name == DeviseActivity.configuration.sign_out_action_name and da_current_user.present? }
    after_action :track_sign_in_activity, if: Proc.new{ controller_name == DeviseActivity.configuration.sign_in_controller_name and action_name == DeviseActivity.configuration.sign_in_action_name and da_current_user.present? }

    protected

    def track_sign_out_activity
      current_session = Session.current(current_user).last
      current_session.signed_out_at = Time.now
      current_session.save
    end

    def track_sign_in_activity
      current_session = Session.current(da_current_user).new
      current_session.signed_in_at = Time.now
      current_session.user_id = da_current_user.id
      current_session.ip_address = request.remote_ip
      current_session.save
    end

    def track_navigation_activity
      current_session = find_or_create_current_session
      navigation = Navigation.create session_id:current_session.id,
                                     page_url: request.original_url,
                                     controller_name: controller_name,
                                     action_name: action_name
    end

    def find_or_create_current_session
      session = Session.current(da_current_user).last
      unless session.present? and session.signed_out_at.nil?
        session = Session.create ip_address: request.remote_ip,
                                 user_id: da_current_user.id,
                                 signed_in_at: Time.now
      end
      session
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
      ActiveRecord::Base.extend DeviseActivity::Extenders::Session
      ActiveRecord::Base.extend DeviseActivity::Extenders::Navigation
    end


  end
end
