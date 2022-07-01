# frozen_string_literal: true

class CreateCalls < ActiveRecord::Migration[6.1]
  def change
    create_table :calls do |t|
      t.integer :app_id
      t.integer :user_id
      t.text :ticket
      t.text :comment
      t.datetime :date

      t.timestamps
    end
  end
end
