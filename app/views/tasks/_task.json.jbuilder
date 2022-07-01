# frozen_string_literal: true

json.extract! task, :id, :assigned_by, :assigned_to, :task, :description, :deadline, :stage, :category, :task_type,
              :resources, :is_priority, :created_at, :updated_at

json.url task_url(task, format: :json)
