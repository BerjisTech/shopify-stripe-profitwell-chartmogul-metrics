# frozen_string_literal: true

class CreateTodos < ActiveRecord::Migration[6.1]
  def change
    create_table :todos do |t|
      t.integer :user_id
      t.text :to_do
      t.datetime :deadline

      t.timestamps
    end
  end
end
