# frozen_string_literal: true

json.array! @task_comment_replies, partial: 'task_comment_replies/task_comment_reply', as: :task_comment_reply
