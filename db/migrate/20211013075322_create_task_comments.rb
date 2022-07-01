# frozen_string_literal: true

class CreateTaskComments < ActiveRecord::Migration[6.1]
  def change
    create_table :task_comments, id: :uuid do |t|
      t.text :comment
      t.uuid :task_id
      t.uuid :user_id

      t.timestamps
    end
  end
end
