# frozen_string_literal: true

require 'test_helper'

class DailyMrrsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @daily_mrr = daily_mrrs(:one)
  end

  test 'should get index' do
    get daily_mrrs_url
    assert_response :success
  end

  test 'should get new' do
    get new_daily_mrr_url
    assert_response :success
  end

  test 'should create daily_mrr' do
    assert_difference('DailyMrr.count') do
      post daily_mrrs_url,
           params: { daily_mrr: { amount: @daily_mrr.amount, app_id: @daily_mrr.app_id, level: @daily_mrr.level } }
    end

    assert_redirected_to daily_mrr_url(DailyMrr.last)
  end

  test 'should show daily_mrr' do
    get daily_mrr_url(@daily_mrr)
    assert_response :success
  end

  test 'should get edit' do
    get edit_daily_mrr_url(@daily_mrr)
    assert_response :success
  end

  test 'should update daily_mrr' do
    patch daily_mrr_url(@daily_mrr),
          params: { daily_mrr: { amount: @daily_mrr.amount, app_id: @daily_mrr.app_id, level: @daily_mrr.level } }
    assert_redirected_to daily_mrr_url(@daily_mrr)
  end

  test 'should destroy daily_mrr' do
    assert_difference('DailyMrr.count', -1) do
      delete daily_mrr_url(@daily_mrr)
    end

    assert_redirected_to daily_mrrs_url
  end
end
