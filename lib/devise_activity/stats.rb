module DeviseActivity
  class Stats
    class << self

      def most_visits_by
        DeviseActivity::Navigation.joins(:session).group("sessions.user_id").count.max_by{|k, v| v }.first
      end

      def least_visits_by
        DeviseActivity::Navigation.joins(:session).group("sessions.user_id").count.min_by{|k, v| v }.first
      end

      def most_popular_action

      end

      def least_popular_action

      end

      def most_popular_controller

      end

      def least_popular_controller

      end

      def most_visited_page

      end

      def most_sign_ins_by

      end

      def sign_ins_count user

      end

    end
  end
end