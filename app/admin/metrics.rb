# frozen_string_literal: true

ActiveAdmin.register Metric do
  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  # permit_params :mrr, :net_revenue, :fees, :other_revenue, :avg_revenue_per_user, :arr, :ltv, :mrr_growth_rate, :user_churn, :revenue_churn, :quick_ratio, :active_customers, :new_customers, :reactivations, :new_subscriptions, :active_subscriptions, :upgrades, :downgrades, :churned_customers, :coupons_redeemed, :failed_charges, :refunds, :app_id, :date, :last_cursor, :time_span, :one_time_charge, :recurring_revenue, :closed_subscription, :deactivations
  #
  # or
  #
  # permit_params do
  #   permitted = [:mrr, :net_revenue, :fees, :other_revenue, :avg_revenue_per_user, :arr, :ltv, :mrr_growth_rate, :user_churn, :revenue_churn, :quick_ratio, :active_customers, :new_customers, :reactivations, :new_subscriptions, :active_subscriptions, :upgrades, :downgrades, :churned_customers, :coupons_redeemed, :failed_charges, :refunds, :app_id, :date, :last_cursor, :time_span, :one_time_charge, :recurring_revenue, :closed_subscription, :deactivations]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end
end
