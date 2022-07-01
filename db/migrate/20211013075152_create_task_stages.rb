# frozen_string_literal: true

class CreateTaskStages < ActiveRecord::Migration[6.1]
  def change
    create_table :task_stages, id: :uuid do |t|
      t.string :stage

      t.timestamps
    end
  end
end
