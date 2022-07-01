# frozen_string_literal: true

class CreateChats < ActiveRecord::Migration[6.1]
  def change
    create_table :chats, id: :uuid do |t|
      t.uuid :user_id
      t.text :chat_link
      t.datetime :date
      t.text :comment

      t.timestamps
    end
  end
end
