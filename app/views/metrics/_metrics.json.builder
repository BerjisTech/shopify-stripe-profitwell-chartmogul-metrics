# frozen_string_literal: true

json.extract! metrics, :id, :mrr, :net_revenue, :one_time_charge, :fees, :other_revenue, :avg_revenue_per_user,
              :arr, :ltv, :mrr_growth_rate, :user_churn, :revenue_churn, :quick_ratio,
              :active_customers, :new_customers, :reactivations, :deactivations,
              :new_subscriptions, :closed_subscription, :active_subscriptions,
              :upgrades, :downgrades, :churned_customers, :coupons_redeemed,
              :failed_charges, :refunds, :created_at, :update_at
json.url task_follower_url(metric, format: :json)
