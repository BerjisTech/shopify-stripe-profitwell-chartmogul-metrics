# frozen_string_literal: true

json.extract! task_stage, :id, :stage, :created_at, :updated_at
json.url task_stage_url(task_stage, format: :json)
