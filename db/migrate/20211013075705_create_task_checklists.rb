# frozen_string_literal: true

class CreateTaskChecklists < ActiveRecord::Migration[6.1]
  def change
    create_table :task_checklists, id: :uuid do |t|
      t.uuid :task_id
      t.text :item
      t.integer :status
      t.uuid :added_by

      t.timestamps
    end
  end
end
