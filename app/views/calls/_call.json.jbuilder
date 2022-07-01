# frozen_string_literal: true

json.extract! call, :id, :app_id, :user_id, :ticket, :comment, :date, :created_at, :updated_at
json.url call_url(call, format: :json)
