# frozen_string_literal: true

class AddClientIdToSlackApi < ActiveRecord::Migration[6.1]
  def change
    add_column :slack_apis, :client_id, :text
  end
end
