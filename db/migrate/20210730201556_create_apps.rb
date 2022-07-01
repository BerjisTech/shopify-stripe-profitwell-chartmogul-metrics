# frozen_string_literal: true

class CreateApps < ActiveRecord::Migration[6.1]
  def change
    create_table :apps do |t|
      t.string :app_name
      t.integer :app_code
      t.integer :partner_id
      t.text :api_key
      t.text :secondary_api_key

      t.timestamps
    end
  end
end
