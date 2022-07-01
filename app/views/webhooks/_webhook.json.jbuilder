# frozen_string_literal: true

json.extract! webhook, :id, :origin, :app_id, :platform, :slag, :created_at, :updated_at
json.url webhook_url(webhook, format: :json)
