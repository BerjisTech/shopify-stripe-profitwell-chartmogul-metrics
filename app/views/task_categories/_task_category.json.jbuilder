# frozen_string_literal: true

json.extract! task_category, :id, :category, :created_at, :updated_at
json.url task_category_url(task_category, format: :json)
