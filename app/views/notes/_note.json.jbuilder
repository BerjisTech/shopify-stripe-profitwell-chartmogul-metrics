# frozen_string_literal: true

json.extract! note, :id, :note, :user_id, :created_at, :updated_at
json.url note_url(note, format: :json)