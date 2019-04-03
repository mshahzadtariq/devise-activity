module DeviseActivity
  class DeviseModel
    DeviseActivity.configuration.devise_model_name.classify.constantize.instance_eval do
      has_many :devise_activity_sessions, class_name: 'DeviseActivity::Session'
    end

    DeviseActivity.configuration.devise_model_name.classify.constantize.class_eval do
      def total_sign_ins
        self.devise_activity_sessions.count
      end

      alias_method :sign_ins_count, :total_sign_ins

      def navigations
        DeviseActivity::Navigation.where("#{DeviseActivity.configuration.sessions_table_name.singularize}_id IN (?)", self.devise_activity_sessions.pluck(:id))
      end
    end
  end
end