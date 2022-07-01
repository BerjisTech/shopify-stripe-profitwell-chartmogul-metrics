# frozen_string_literal: true

require 'test_helper'

class HomeControllerTest < ActionDispatch::IntegrationTest
  test 'should get index' do
    get home_index_url
    assert_response :success
  end

  test 'should get about' do
    get home_about_url
    assert_response :success
  end

  test 'should get pricing' do
    get home_pricing_url
    assert_response :success
  end

  test 'should get faq' do
    get home_faq_url
    assert_response :success
  end

  test 'should get privacy_policy' do
    get home_privacy_policy_url
    assert_response :success
  end

  test 'should get terms_and_conditions' do
    get home_terms_and_conditions_url
    assert_response :success
  end

  test 'should get refund_policy' do
    get home_refund_policy_url
    assert_response :success
  end

  test 'should get api' do
    get home_api_url
    assert_response :success
  end

  test 'should get docs' do
    get home_docs_url
    assert_response :success
  end

  test 'should get support' do
    get home_support_url
    assert_response :success
  end

  test 'should get help' do
    get home_help_url
    assert_response :success
  end
end
