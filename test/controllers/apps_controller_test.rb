# frozen_string_literal: true

require 'test_helper'

class AppsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @app = apps(:one)
  end

  test 'should get index' do
    get apps_url
    assert_response :success
  end

  test 'should get new' do
    get new_app_url
    assert_response :success
  end

  test 'should create app' do
    assert_difference('App.count') do
      post apps_url,
           params: { app: { api_key: @app.api_key, app_code: @app.app_code, app_name: @app.app_name, partner_id: @app.partner_id,
                            secondary_api_key: @app.secondary_api_key } }
    end

    assert_redirected_to app_url(App.last)
  end

  test 'should show app' do
    get app_url(@app)
    assert_response :success
  end

  test 'should get edit' do
    get edit_app_url(@app)
    assert_response :success
  end

  test 'should update app' do
    patch app_url(@app),
          params: { app: { api_key: @app.api_key, app_code: @app.app_code, app_name: @app.app_name, partner_id: @app.partner_id,
                           secondary_api_key: @app.secondary_api_key } }
    assert_redirected_to app_url(@app)
  end

  test 'should destroy app' do
    assert_difference('App.count', -1) do
      delete app_url(@app)
    end

    assert_redirected_to apps_url
  end
end
