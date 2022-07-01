# frozen_string_literal: true

json.extract! request, :id, :requested_by, :requested_from, :request, :provided, :created_at, :updated_at
json.url request_url(request, format: :json)
