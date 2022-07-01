# frozen_string_literal: true

class AddPricesToContest < ActiveRecord::Migration[6.1]
  def change
    add_column :contests, :request_price, :float
    add_column :contests, :received_price, :float
    add_column :contests, :chat_price, :float
    add_column :contests, :call_price, :float
    add_column :contests, :app_id, :uuid
    add_column :contests, :platform_id, :uuid
  end
end
