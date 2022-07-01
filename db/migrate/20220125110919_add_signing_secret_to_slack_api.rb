# frozen_string_literal: true

class AddSigningSecretToSlackApi < ActiveRecord::Migration[6.1]
  def change
    add_column :slack_apis, :signing_secret, :text
  end
end
