# frozen_string_literal: true

class CreateSuggestions < ActiveRecord::Migration[6.1]
  def change
    create_table :suggestions do |t|
      t.integer :user_id
      t.integer :app_id
      t.text :suggestion

      t.timestamps
    end
  end
end
