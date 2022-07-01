# frozen_string_literal: true

class CreateTaskFollowers < ActiveRecord::Migration[6.1]
  def change
    create_table :task_followers, id: :uuid do |t|
      t.uuid :task_id
      t.uuid :user_id

      t.timestamps
    end
  end
end
