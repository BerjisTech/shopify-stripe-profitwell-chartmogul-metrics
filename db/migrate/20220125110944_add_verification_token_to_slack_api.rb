# frozen_string_literal: true

class AddVerificationTokenToSlackApi < ActiveRecord::Migration[6.1]
  def change
    add_column :slack_apis, :verification_token, :text
  end
end
