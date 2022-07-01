# frozen_string_literal: true

class CreateAffiliates < ActiveRecord::Migration[6.1]
  def change
    create_table :affiliates do |t|
      t.integer :app_id
      t.string :platform

      t.timestamps
    end
  end
end
