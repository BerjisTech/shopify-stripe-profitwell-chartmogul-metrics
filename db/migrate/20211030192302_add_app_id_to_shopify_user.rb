# frozen_string_literal: true

class AddAppIdToShopifyUser < ActiveRecord::Migration[6.1]
  def change
    add_column :shopify_users, :app_id, :uuid
  end
end
