# frozen_string_literal: true

class CreateErrors < ActiveRecord::Migration[6.1]
  def change
    create_table :errors do |t|
      t.json :error
      t.text :origin
      t.string :controller
      t.string :method

      t.timestamps
    end
  end
end
