# frozen_string_literal: true

json.extract! sub_task, :id, :task, :assigned_to, :assigned_by, :deadline, :created_at, :updated_at
json.url sub_task_url(sub_task, format: :json)
