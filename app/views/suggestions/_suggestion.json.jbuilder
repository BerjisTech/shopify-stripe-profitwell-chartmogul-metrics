# frozen_string_literal: true

json.extract! suggestion, :id, :user_id, :app_id, :suggestion, :created_at, :updated_at
json.url suggestion_url(suggestion, format: :json)
