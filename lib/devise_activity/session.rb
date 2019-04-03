module DeviseActivity
  class Session < ApplicationRecord
    self.table_name = DeviseActivity.configuration.sessions_table_name

    #scope :current, ->(current_user){ where(user_id: current_user.id)}

    has_many :navigations, class_name: 'DeviseActivity::Navigation'

    belongs_to DeviseActivity.configuration.devise_model_name.to_sym

    class << self
      def current user
        where(user_id: user.id, signed_out_at: nil).last
      end

      def start_new_session record
        Session.create signed_in_at: Time.now,
                       user_id: record.id

      end

      def close_all_previous_sessions record
        Session.where(user_id: record.id, signed_out_at: nil).update_all(signed_out_at: Time.now)
      end
    end

  end
end