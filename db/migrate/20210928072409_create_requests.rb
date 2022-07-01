# frozen_string_literal: true

class CreateRequests < ActiveRecord::Migration[6.1]
  def change
    create_table :requests do |t|
      t.integer :requested_by
      t.integer :requested_from
      t.text :request
      t.integer :provided

      t.timestamps
    end
  end
end
