# frozen_string_literal: true

class CreateTaskLogs < ActiveRecord::Migration[6.1]
  def change
    create_table :task_logs, id: :uuid do |t|
      t.uuid :task
      t.text :log
      t.uuid :operator

      t.timestamps
    end
  end
end
