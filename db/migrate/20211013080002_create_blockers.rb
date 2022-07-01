# frozen_string_literal: true

class CreateBlockers < ActiveRecord::Migration[6.1]
  def change
    create_table :blockers, id: :uuid do |t|
      t.text :item
      t.uuid :added_by

      t.timestamps
    end
  end
end
