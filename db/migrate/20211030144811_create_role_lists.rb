# frozen_string_literal: true

class CreateRoleLists < ActiveRecord::Migration[6.1]
  def change
    create_table :role_lists, id: :uuid do |t|
      t.string :name
      t.uuid :role_id

      t.timestamps
    end
  end
end
