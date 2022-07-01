# frozen_string_literal: true

class CreateSlackApis < ActiveRecord::Migration[6.1]
  def change
    create_table :slack_apis, id: :uuid do |t|
      t.text :current_bot_token
      t.text :current_user_token
      t.text :current_user_rotation
      t.text :current_bot_rotation

      t.timestamps
    end
  end
end
