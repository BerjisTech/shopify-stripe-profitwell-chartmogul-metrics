# frozen_string_literal: true

class CreateWebhooks < ActiveRecord::Migration[6.1]
  def change
    create_table :webhooks do |t|
      t.text :origin
      t.integer :app_id
      t.string :platform
      t.string :slag

      t.timestamps
    end
  end
end
