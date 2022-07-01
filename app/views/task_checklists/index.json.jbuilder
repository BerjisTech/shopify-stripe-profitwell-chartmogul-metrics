# frozen_string_literal: true

json.array! @task_checklists, partial: 'task_checklists/task_checklist', as: :task_checklist
