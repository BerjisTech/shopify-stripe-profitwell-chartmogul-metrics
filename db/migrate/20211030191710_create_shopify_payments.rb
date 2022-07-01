# frozen_string_literal: true

class CreateShopifyPayments < ActiveRecord::Migration[6.1]
  def change
    create_table :shopify_payments, id: :uuid do |t|
      t.datetime :date
      t.datetime :billing_period_start
      t.datetime :billing_period_end
      t.text :payment_duration
      t.text :shop_name
      t.text :shop_domain
      t.text :shop_email
      t.string :shop_country
      t.text :details
      t.text :charge_type
      t.float :partner_sale
      t.float :shopify_fee
      t.float :processing_fee
      t.float :partner_share
      t.text :charge_id

      t.timestamps
    end
  end
end
