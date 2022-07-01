# frozen_string_literal: true

require 'test_helper'

class DailyCountsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @daily_count = daily_counts(:one)
  end

  test 'should get index' do
    get daily_counts_url
    assert_response :success
  end

  test 'should get new' do
    get new_daily_count_url
    assert_response :success
  end

  test 'should create daily_count' do
    assert_difference('DailyCount.count') do
      post daily_counts_url,
           params: { daily_count: { app_id: @daily_count.app_id, date: @daily_count.date, plan_id: @daily_count.plan_id,
                                    user_count: @daily_count.user_count } }
    end

    assert_redirected_to daily_count_url(DailyCount.last)
  end

  test 'should show daily_count' do
    get daily_count_url(@daily_count)
    assert_response :success
  end

  test 'should get edit' do
    get edit_daily_count_url(@daily_count)
    assert_response :success
  end

  test 'should update daily_count' do
    patch daily_count_url(@daily_count),
          params: { daily_count: { app_id: @daily_count.app_id, date: @daily_count.date, plan_id: @daily_count.plan_id,
                                   user_count: @daily_count.user_count } }
    assert_redirected_to daily_count_url(@daily_count)
  end

  test 'should destroy daily_count' do
    assert_difference('DailyCount.count', -1) do
      delete daily_count_url(@daily_count)
    end

    assert_redirected_to daily_counts_url
  end
end
