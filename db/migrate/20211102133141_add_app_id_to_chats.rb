# frozen_string_literal: true

class AddAppIdToChats < ActiveRecord::Migration[6.1]
  def change
    add_column :chats, :app_id, :uuid
  end
end
