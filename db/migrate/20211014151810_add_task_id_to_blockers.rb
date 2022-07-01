# frozen_string_literal: true

class AddTaskIdToBlockers < ActiveRecord::Migration[6.1]
  def change
    add_column :blockers, :task_id, :uuid
  end
end
