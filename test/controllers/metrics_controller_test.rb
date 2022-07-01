# frozen_string_literal: true

require 'test_helper'

class MetricsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @metric = metrics(:one)
  end

  test 'should get index' do
    get metrics_url
    assert_response :success
  end

  test 'should get new' do
    get new_metric_url
    assert_response :success
  end

  test 'should create metric' do
    assert_difference('Metric.count') do
      post metrics_url,
           params: { metric: { active_customers: @metric.active_customers, active_subscriptions: @metric.active_subscriptions,
                               arr: @metric.arr, avg_revenue_per_user: @metric.avg_revenue_per_user, churned_customers: @metric.churned_customers, coupons_redeemed: @metric.coupons_redeemed, downgrades: @metric.downgrades, failed_charges: @metric.failed_charges, fees: @metric.fees, ltv: @metric.ltv, mrr: @metric.mrr, mrr_growth_rate: @metric.mrr_growth_rate, net_revenue: @metric.net_revenue, new_customers: @metric.new_customers, new_subscriptions: @metric.new_subscriptions, other_revenue: @metric.other_revenue, quick_ratio: @metric.quick_ratio, reactivations: @metric.reactivations, refunds: @metric.refunds, revenue_churn: @metric.revenue_churn, upgrades: @metric.upgrades, user_churn: @metric.user_churn } }
    end

    assert_redirected_to metric_url(Metric.last)
  end

  test 'should show metric' do
    get metric_url(@metric)
    assert_response :success
  end

  test 'should get edit' do
    get edit_metric_url(@metric)
    assert_response :success
  end

  test 'should update metric' do
    patch metric_url(@metric),
          params: { metric: { active_customers: @metric.active_customers, active_subscriptions: @metric.active_subscriptions,
                              arr: @metric.arr, avg_revenue_per_user: @metric.avg_revenue_per_user, churned_customers: @metric.churned_customers, coupons_redeemed: @metric.coupons_redeemed, downgrades: @metric.downgrades, failed_charges: @metric.failed_charges, fees: @metric.fees, ltv: @metric.ltv, mrr: @metric.mrr, mrr_growth_rate: @metric.mrr_growth_rate, net_revenue: @metric.net_revenue, new_customers: @metric.new_customers, new_subscriptions: @metric.new_subscriptions, other_revenue: @metric.other_revenue, quick_ratio: @metric.quick_ratio, reactivations: @metric.reactivations, refunds: @metric.refunds, revenue_churn: @metric.revenue_churn, upgrades: @metric.upgrades, user_churn: @metric.user_churn } }
    assert_redirected_to metric_url(@metric)
  end

  test 'should destroy metric' do
    assert_difference('Metric.count', -1) do
      delete metric_url(@metric)
    end

    assert_redirected_to metrics_url
  end
end
