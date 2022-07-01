# frozen_string_literal: true

class CreateEvents < ActiveRecord::Migration[6.1]
  def change
    create_table :events do |t|
      t.integer :app_id
      t.text :website
      t.text :email
      t.text :event
      t.datetime :time

      t.timestamps
    end
  end
end
