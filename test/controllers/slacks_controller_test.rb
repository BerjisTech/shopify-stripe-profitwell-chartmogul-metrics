# frozen_string_literal: true

require 'test_helper'

class SlacksControllerTest < ActionDispatch::IntegrationTest
  setup do
    @slack = slacks(:one)
  end

  test 'should get index' do
    get slacks_url
    assert_response :success
  end

  test 'should get new' do
    get new_slack_url
    assert_response :success
  end

  test 'should create slack' do
    assert_difference('Slack.count') do
      post slacks_url, params: { slack: { event: @slack.event } }
    end

    assert_redirected_to slack_url(Slack.last)
  end

  test 'should show slack' do
    get slack_url(@slack)
    assert_response :success
  end

  test 'should get edit' do
    get edit_slack_url(@slack)
    assert_response :success
  end

  test 'should update slack' do
    patch slack_url(@slack), params: { slack: { event: @slack.event } }
    assert_redirected_to slack_url(@slack)
  end

  test 'should destroy slack' do
    assert_difference('Slack.count', -1) do
      delete slack_url(@slack)
    end

    assert_redirected_to slacks_url
  end
end
