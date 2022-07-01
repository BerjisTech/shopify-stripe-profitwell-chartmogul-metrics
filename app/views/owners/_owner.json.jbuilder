# frozen_string_literal: true

json.extract! owner, :id, :app_id, :user_id, :level, :status, :created_at, :updated_at
json.url owner_url(owner, format: :json)
