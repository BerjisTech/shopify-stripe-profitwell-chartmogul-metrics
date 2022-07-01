# frozen_string_literal: true

class CreateSubTasks < ActiveRecord::Migration[6.1]
  def change
    create_table :sub_tasks, id: :uuid do |t|
      t.text :task
      t.uuid :assigned_to
      t.uuid :assigned_by
      t.datetime :deadline

      t.timestamps
    end
  end
end
