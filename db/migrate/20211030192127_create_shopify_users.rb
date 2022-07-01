# frozen_string_literal: true

class CreateShopifyUsers < ActiveRecord::Migration[6.1]
  def change
    create_table :shopify_users, id: :uuid do |t|
      t.text :shop_name
      t.text :shop_domain
      t.text :shop_email
      t.string :shop_country
      t.string :shop_plan
      t.datetime :install_date

      t.timestamps
    end
  end
end
