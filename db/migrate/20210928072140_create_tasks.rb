# frozen_string_literal: true

class CreateTasks < ActiveRecord::Migration[6.1]
  def change
    create_table :tasks do |t|
      t.integer :assigned_by
      t.integer :assigned_to
      t.string :task
      t.text :description
      t.datetime :deadline

      t.timestamps
    end
  end
end
