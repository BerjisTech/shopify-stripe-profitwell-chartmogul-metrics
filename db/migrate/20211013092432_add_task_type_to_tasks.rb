# frozen_string_literal: true

class AddTaskTypeToTasks < ActiveRecord::Migration[6.1]
  def change
    add_column :tasks, :task_type, :uuid
  end
end
