# frozen_string_literal: true

json.extract! review, :id, :app_id, :rating, :user_id, :ticket, :comment, :created_at, :updated_at, :requested_on,
              :received_on, :type
json.url review_url(review, format: :json)
