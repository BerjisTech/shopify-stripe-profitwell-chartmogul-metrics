# frozen_string_literal: true

class CreateTaskTypes < ActiveRecord::Migration[6.1]
  def change
    create_table :task_types, id: :uuid do |t|
      t.text :name

      t.timestamps
    end
  end
end
