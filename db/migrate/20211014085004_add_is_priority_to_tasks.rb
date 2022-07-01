# frozen_string_literal: true

class AddIsPriorityToTasks < ActiveRecord::Migration[6.1]
  def change
    add_column :tasks, :is_priority, :integer
  end
end
