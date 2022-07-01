# frozen_string_literal: true

json.extract! task_checklist, :id, :task_id, :item, :status, :added_by, :created_at, :updated_at
json.url task_checklist_url(task_checklist, format: :json)
