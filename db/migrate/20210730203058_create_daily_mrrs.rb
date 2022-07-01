# frozen_string_literal: true

class CreateDailyMrrs < ActiveRecord::Migration[6.1]
  def change
    create_table :daily_mrrs do |t|
      t.integer :app_id
      t.integer :level
      t.float :amount

      t.timestamps
    end
  end
end
