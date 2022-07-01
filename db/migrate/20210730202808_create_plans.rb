# frozen_string_literal: true

class CreatePlans < ActiveRecord::Migration[6.1]
  def change
    create_table :plans do |t|
      t.integer :app_id
      t.text :name
      t.float :price

      t.timestamps
    end
  end
end
