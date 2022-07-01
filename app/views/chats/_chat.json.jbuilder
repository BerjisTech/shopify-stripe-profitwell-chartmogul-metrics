# frozen_string_literal: true

json.extract! chat, :id, :user_id, :chat_link, :date, :comment, :created_at, :updated_at
json.url chat_url(chat, format: :json)
