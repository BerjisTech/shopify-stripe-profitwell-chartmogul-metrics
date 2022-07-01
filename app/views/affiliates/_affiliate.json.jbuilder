# frozen_string_literal: true

json.extract! affiliate, :id, :app_id, :platform, :created_at, :updated_at
json.url affiliate_url(affiliate, format: :json)
