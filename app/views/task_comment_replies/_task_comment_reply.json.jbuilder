# frozen_string_literal: true

json.extract! task_comment_reply, :id, :reply, :task_comment_id, :user_id, :task_id, :created_at, :updated_at
json.url task_comment_reply_url(task_comment_reply, format: :json)
