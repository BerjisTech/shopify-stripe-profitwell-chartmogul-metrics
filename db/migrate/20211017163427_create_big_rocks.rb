# frozen_string_literal: true

class CreateBigRocks < ActiveRecord::Migration[6.1]
  def change
    create_table :big_rocks, id: :uuid do |t|
      t.uuid :owner
      t.uuid :category
      t.integer :quater
      t.text :rock
      t.integer :status

      t.timestamps
    end
  end
end
