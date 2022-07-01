# frozen_string_literal: true

class CreateOwners < ActiveRecord::Migration[6.1]
  def change
    create_table :owners do |t|
      t.integer :app_id
      t.integer :user_id
      t.integer :level
      t.integer :status

      t.timestamps
    end
  end
end
