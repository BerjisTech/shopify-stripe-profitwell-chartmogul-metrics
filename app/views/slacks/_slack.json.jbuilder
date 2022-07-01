# frozen_string_literal: true

json.extract! slack, :id, :event, :created_at, :updated_at
json.url slack_url(slack, format: :json)
