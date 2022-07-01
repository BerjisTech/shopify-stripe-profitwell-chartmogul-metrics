# frozen_string_literal: true

json.array! @task_types, partial: 'task_types/task_type', as: :task_type
