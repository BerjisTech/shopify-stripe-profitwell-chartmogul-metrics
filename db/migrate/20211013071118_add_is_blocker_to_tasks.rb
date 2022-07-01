# frozen_string_literal: true

class AddIsBlockerToTasks < ActiveRecord::Migration[6.1]
  def change
    add_column :tasks, :is_blocker, :integer
  end
end
