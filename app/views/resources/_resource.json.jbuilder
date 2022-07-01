# frozen_string_literal: true

json.extract! resource, :id, :resource, :task_id, :created_at, :updated_at
json.url resource_url(resource, format: :json)
