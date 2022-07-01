# frozen_string_literal: true

class CreateGroupMembers < ActiveRecord::Migration[6.1]
  def change
    create_table :group_members do |t|
      t.integer :group_id
      t.integer :user_id
      t.integer :status

      t.timestamps
    end
  end
end
