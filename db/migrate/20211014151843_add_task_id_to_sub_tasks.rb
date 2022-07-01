# frozen_string_literal: true

class AddTaskIdToSubTasks < ActiveRecord::Migration[6.1]
  def change
    add_column :sub_tasks, :task_id, :uuid
  end
end
