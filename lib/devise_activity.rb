require 'devise_activity/configuration'
require 'active_record'


module DeviseActivity
  require 'devise_activity/session'
  require 'devise_activity/navigation'

  extend ActiveSupport::Concern

  included do

    before_action :track_user_activity

    protected

    def track_user_activity
      DeviseActivity::Session.create
      DeviseActivity::Navigation.create
    end

  end

  class << self
    attr_accessor :configuration
  end

  def self.configure
    self.configuration ||= Configuration.new
    yield(configuration)
  end
end
