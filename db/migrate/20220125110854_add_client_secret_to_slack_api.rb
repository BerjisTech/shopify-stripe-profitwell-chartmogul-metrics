# frozen_string_literal: true

class AddClientSecretToSlackApi < ActiveRecord::Migration[6.1]
  def change
    add_column :slack_apis, :client_secret, :text
  end
end
