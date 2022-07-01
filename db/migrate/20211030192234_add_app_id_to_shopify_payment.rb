# frozen_string_literal: true

class AddAppIdToShopifyPayment < ActiveRecord::Migration[6.1]
  def change
    add_column :shopify_payments, :app_id, :uuid
  end
end
