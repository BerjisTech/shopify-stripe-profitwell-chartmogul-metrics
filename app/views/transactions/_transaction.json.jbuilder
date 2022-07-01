# frozen_string_literal: true

json.extract! transaction, :id, :amount, :reason, :type, :app_id, :created_at, :updated_at
json.url transaction_url(transaction, format: :json)
