# frozen_string_literal: true

json.extract! daily_mrr, :id, :app_id, :level, :amount, :created_at, :updated_at
json.url daily_mrr_url(daily_mrr, format: :json)
