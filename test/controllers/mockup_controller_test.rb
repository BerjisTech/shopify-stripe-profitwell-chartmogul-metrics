# frozen_string_literal: true

require 'test_helper'

class MockupControllerTest < ActionDispatch::IntegrationTest
  test 'should get apps' do
    get mockup_apps_url
    assert_response :success
  end

  test 'should get app' do
    get mockup_app_url
    assert_response :success
  end

  test 'should get businesses' do
    get mockup_businesses_url
    assert_response :success
  end

  test 'should get business' do
    get mockup_business_url
    assert_response :success
  end

  test 'should get control_center' do
    get mockup_control_center_url
    assert_response :success
  end

  test 'should get metrics' do
    get mockup_metrics_url
    assert_response :success
  end
end
