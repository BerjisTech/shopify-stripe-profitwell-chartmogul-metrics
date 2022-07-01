# frozen_string_literal: true

json.array! @task_stages, partial: 'task_stages/task_stage', as: :task_stage
