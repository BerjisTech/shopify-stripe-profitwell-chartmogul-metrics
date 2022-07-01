# frozen_string_literal: true

class CreateDailyCounts < ActiveRecord::Migration[6.1]
  def change
    create_table :daily_counts do |t|
      t.integer :app_id
      t.integer :user_count
      t.datetime :date
      t.integer :plan_id

      t.timestamps
    end
  end
end
