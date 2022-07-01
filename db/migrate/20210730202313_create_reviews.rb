# frozen_string_literal: true

class CreateReviews < ActiveRecord::Migration[6.1]
  def change
    create_table :reviews do |t|
      t.integer :app_id
      t.float :rating
      t.integer :user_id
      t.text :ticket
      t.text :comment

      t.timestamps
    end
  end
end
