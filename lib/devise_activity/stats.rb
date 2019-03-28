module DeviseActivity
  class Stats
    class << self

      def most_visits_by
        DeviseActivity.configuration.devise_model_name.classify.constantize.find(DeviseActivity::Navigation.joins(:session).group("sessions.user_id").count.max_by{|k, v| v }.first) rescue nil
      end

      def least_visits_by
        DeviseActivity.configuration.devise_model_name.classify.constantize.find(DeviseActivity::Navigation.joins(:session).group("sessions.user_id").count.min_by{|k, v| v }.first) rescue nil
      end

      def most_popular_action
        DeviseActivity::Navigation.group("action_name").count.max_by{|k, v| v}.first
      end

      def least_popular_action
        DeviseActivity::Navigation.group("action_name").count.min_by{|k, v| v}.first
      end

      def most_popular_controller
        DeviseActivity::Navigation.group("controller_name").count.max_by{|k, v| v}.first
      end

      def least_popular_controller
        DeviseActivity::Navigation.group("controller_name").count.min_by{|k, v| v}.first
      end

      def most_visited_page
        DeviseActivity::Navigation.group("page_url").count.max_by{|k, v| v}.first
      end

      def least_visited_page
        DeviseActivity::Navigation.group("page_url").count.min_by{|k, v| v}.first
      end

      def most_sign_ins_by
        DeviseActivity.configuration.devise_model_name.classify.constantize.find((DeviseActivity::Session.group("#{DeviseActivity.configuration.devise_model_name}_id").count.max_by{|k, v| v }.first) rescue nil
      end

      def total_sign_ins obj
        Session.where("#{DeviseActivity.configuration.devise_model_name}_id = ?", obj.id).count
      end

    end
  end
end