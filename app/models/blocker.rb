# frozen_string_literal: true

# Blockers Model
class Blocker < ApplicationRecord
  def self.per_task(task_id)
    Blocker.where(task_id: task_id).order(created_at: :asc)
  end
end
