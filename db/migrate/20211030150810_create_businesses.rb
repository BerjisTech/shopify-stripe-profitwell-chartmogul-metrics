# frozen_string_literal: true

class CreateBusinesses < ActiveRecord::Migration[6.1]
  def change
    create_table :businesses, id: :uuid do |t|
      t.string :name

      t.timestamps
    end
  end
end
