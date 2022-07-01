# frozen_string_literal: true

class CreateMetrics < ActiveRecord::Migration[6.1]
  def change
    create_table :metrics, id: :uuid do |t|
      t.float :mrr
      t.float :net_revenue
      t.float :fees
      t.float :other_revenue
      t.float :avg_revenue_per_user
      t.float :arr
      t.float :ltv
      t.float :mrr_growth_rate
      t.float :user_churn
      t.float :revenue_churn
      t.float :quick_ratio
      t.integer :active_customers
      t.integer :new_customers
      t.integer :reactivations
      t.integer :new_subscriptions
      t.integer :active_subscriptions
      t.integer :upgrades
      t.integer :downgrades
      t.integer :churned_customers
      t.float :coupons_redeemed
      t.integer :failed_charges
      t.float :refunds

      t.timestamps
    end
  end
end
