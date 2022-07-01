# frozen_string_literal: true

json.extract! app_group, :id, :group_name, :group_description, :created_at, :updated_at
json.url app_group_url(app_group, format: :json)
