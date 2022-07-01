# frozen_string_literal: true

class CreateNotes < ActiveRecord::Migration[6.1]
  def change
    create_table :notes do |t|
      t.text :note
      t.integer :user_id

      t.timestamps
    end
  end
end
