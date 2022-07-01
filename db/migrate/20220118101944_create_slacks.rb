# frozen_string_literal: true

class CreateSlacks < ActiveRecord::Migration[6.1]
  def change
    create_table :slacks, id: :uuid do |t|
      t.string :event

      t.timestamps
    end
  end
end
