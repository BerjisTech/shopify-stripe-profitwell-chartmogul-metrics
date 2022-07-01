# frozen_string_literal: true

json.extract! event, :id, :app_id, :website, :email, :event, :time, :created_at, :updated_at
json.url event_url(event, format: :json)
