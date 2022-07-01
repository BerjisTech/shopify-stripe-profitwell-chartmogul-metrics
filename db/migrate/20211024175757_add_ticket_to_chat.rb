# frozen_string_literal: true

class AddTicketToChat < ActiveRecord::Migration[6.1]
  def change
    add_column :chats, :ticket, :text
  end
end
