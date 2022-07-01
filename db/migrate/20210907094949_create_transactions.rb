# frozen_string_literal: true

class CreateTransactions < ActiveRecord::Migration[6.1]
  def change
    create_table :transactions do |t|
      t.float :amount
      t.text :reason
      t.integer :type
      t.integer :app_id

      t.timestamps
    end
  end
end
