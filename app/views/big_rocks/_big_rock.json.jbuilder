# frozen_string_literal: true

json.extract! big_rock, :id, :owner, :category, :quater, :year, :rock, :status, :created_at, :updated_at
json.url big_rock_url(big_rock, format: :json)
