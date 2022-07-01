# frozen_string_literal: true

json.extract! api, :id, :app_id, :name, :key, :secret, :password, :secondary, :endpoint, :partner_id, :app_code,
              :created_at, :updated_at
json.url api_url(api, format: :json)
