# frozen_string_literal: true

json.array! @task_followers, partial: 'task_followers/task_follower', as: :task_follower
