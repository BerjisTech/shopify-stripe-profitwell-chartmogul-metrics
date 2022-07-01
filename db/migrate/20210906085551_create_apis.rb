# frozen_string_literal: true

class CreateApis < ActiveRecord::Migration[6.1]
  def change
    create_table :apis do |t|
      t.integer :app_id
      t.string :name
      t.text :key
      t.text :secret
      t.text :password
      t.text :secondary

      t.timestamps
    end
  end
end
