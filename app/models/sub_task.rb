# frozen_string_literal: true

# Subtask Model
class SubTask < ApplicationRecord
  def self.per_task(task_id)
    SubTask.where(task_id: task_id).order(created_at: :asc)
  end
end
