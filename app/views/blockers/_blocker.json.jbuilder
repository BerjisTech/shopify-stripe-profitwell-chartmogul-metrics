# frozen_string_literal: true

json.extract! blocker, :id, :item, :added_by, :created_at, :updated_at
json.url blocker_url(blocker, format: :json)
