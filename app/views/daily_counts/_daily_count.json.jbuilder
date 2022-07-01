# frozen_string_literal: true

json.extract! daily_count, :id, :app_id, :user_count, :date, :plan_id, :created_at, :updated_at
json.url daily_count_url(daily_count, format: :json)
