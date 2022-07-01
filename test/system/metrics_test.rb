# frozen_string_literal: true

require 'application_system_test_case'

class MetricsTest < ApplicationSystemTestCase
  setup do
    @metric = metrics(:one)
  end

  test 'visiting the index' do
    visit metrics_url
    assert_selector 'h1', text: 'Metrics'
  end

  test 'creating a Metric' do
    visit metrics_url
    click_on 'New Metric'

    fill_in 'Active customers', with: @metric.active_customers
    fill_in 'Active subscriptions', with: @metric.active_subscriptions
    fill_in 'Arr', with: @metric.arr
    fill_in 'Avg revenue per user', with: @metric.avg_revenue_per_user
    fill_in 'Churned customers', with: @metric.churned_customers
    fill_in 'Coupons redeemed', with: @metric.coupons_redeemed
    fill_in 'Downgrades', with: @metric.downgrades
    fill_in 'Failed charges', with: @metric.failed_charges
    fill_in 'Fees', with: @metric.fees
    fill_in 'Ltv', with: @metric.ltv
    fill_in 'Mrr', with: @metric.mrr
    fill_in 'Mrr growth rate', with: @metric.mrr_growth_rate
    fill_in 'Net revenue', with: @metric.net_revenue
    fill_in 'New customers', with: @metric.new_customers
    fill_in 'New subscriptions', with: @metric.new_subscriptions
    fill_in 'Other revenue', with: @metric.other_revenue
    fill_in 'Quick ratio', with: @metric.quick_ratio
    fill_in 'Reactivations', with: @metric.reactivations
    fill_in 'Refunds', with: @metric.refunds
    fill_in 'Revenue churn', with: @metric.revenue_churn
    fill_in 'Upgrades', with: @metric.upgrades
    fill_in 'User churn', with: @metric.user_churn
    click_on 'Create Metric'

    assert_text 'Metric was successfully created'
    click_on 'Back'
  end

  test 'updating a Metric' do
    visit metrics_url
    click_on 'Edit', match: :first

    fill_in 'Active customers', with: @metric.active_customers
    fill_in 'Active subscriptions', with: @metric.active_subscriptions
    fill_in 'Arr', with: @metric.arr
    fill_in 'Avg revenue per user', with: @metric.avg_revenue_per_user
    fill_in 'Churned customers', with: @metric.churned_customers
    fill_in 'Coupons redeemed', with: @metric.coupons_redeemed
    fill_in 'Downgrades', with: @metric.downgrades
    fill_in 'Failed charges', with: @metric.failed_charges
    fill_in 'Fees', with: @metric.fees
    fill_in 'Ltv', with: @metric.ltv
    fill_in 'Mrr', with: @metric.mrr
    fill_in 'Mrr growth rate', with: @metric.mrr_growth_rate
    fill_in 'Net revenue', with: @metric.net_revenue
    fill_in 'New customers', with: @metric.new_customers
    fill_in 'New subscriptions', with: @metric.new_subscriptions
    fill_in 'Other revenue', with: @metric.other_revenue
    fill_in 'Quick ratio', with: @metric.quick_ratio
    fill_in 'Reactivations', with: @metric.reactivations
    fill_in 'Refunds', with: @metric.refunds
    fill_in 'Revenue churn', with: @metric.revenue_churn
    fill_in 'Upgrades', with: @metric.upgrades
    fill_in 'User churn', with: @metric.user_churn
    click_on 'Update Metric'

    assert_text 'Metric was successfully updated'
    click_on 'Back'
  end

  test 'destroying a Metric' do
    visit metrics_url
    page.accept_confirm do
      click_on 'Destroy', match: :first
    end

    assert_text 'Metric was successfully destroyed'
  end
end
