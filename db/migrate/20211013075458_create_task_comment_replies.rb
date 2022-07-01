# frozen_string_literal: true

class CreateTaskCommentReplies < ActiveRecord::Migration[6.1]
  def change
    create_table :task_comment_replies, id: :uuid do |t|
      t.text :reply
      t.uuid :task_comment_id
      t.uuid :user_id
      t.uuid :task_id

      t.timestamps
    end
  end
end
