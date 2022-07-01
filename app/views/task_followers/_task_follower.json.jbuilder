# frozen_string_literal: true

json.extract! task_follower, :id, :task_id, :user_id, :created_at, :updated_at
json.url task_follower_url(task_follower, format: :json)
