# frozen_string_literal: true

json.extract! plan, :id, :app_id, :name, :price, :created_at, :updated_at
json.url plan_url(plan, format: :json)
