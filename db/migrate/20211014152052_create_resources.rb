# frozen_string_literal: true

class CreateResources < ActiveRecord::Migration[6.1]
  def change
    create_table :resources, id: :uuid do |t|
      t.text :resource
      t.uuid :task_id

      t.timestamps
    end
  end
end
