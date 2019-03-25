module DeviseActivity
  class Session < ApplicationRecord
    self.table_name = DeviseActivity.configuration.sessions_table_name

    scope :current, ->(current_user){ where(user_id: current_user.id)}

    has_many :navigations, class_name: 'DeviseActivity::Navigation'

  end
end