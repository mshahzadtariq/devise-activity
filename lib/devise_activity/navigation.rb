module DeviseActivity
  class Navigation < ApplicationRecord
    self.table_name = DeviseActivity.configuration.navigations_table_name

    belongs_to :session, class_name: 'DeviseActivity::Session'

  end
end