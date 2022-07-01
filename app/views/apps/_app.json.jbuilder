# frozen_string_literal: true

json.extract! app, :id, :app_name, :app_code, :partner_id, :api_key, :secondary_api_key, :created_at, :updated_at
json.url app_url(app, format: :json)
