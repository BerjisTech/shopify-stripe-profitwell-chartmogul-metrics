# frozen_string_literal: true

class CreateRoles < ActiveRecord::Migration[6.1]
  def change
    create_table :roles do |t|
      t.integer :user_id
      t.string :name

      t.timestamps
    end
  end
end
