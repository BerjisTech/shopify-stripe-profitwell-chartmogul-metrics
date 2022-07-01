# frozen_string_literal: true

json.extract! group_member, :id, :group_id, :user_id, :status, :created_at, :updated_at
json.url group_member_url(group_member, format: :json)
