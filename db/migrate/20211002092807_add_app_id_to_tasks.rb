# frozen_string_literal: true

class AddAppIdToTasks < ActiveRecord::Migration[6.1]
  def change
    add_column :tasks, :app_id, :integer
  end
end
