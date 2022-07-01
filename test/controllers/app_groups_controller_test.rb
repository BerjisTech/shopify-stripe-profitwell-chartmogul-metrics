# frozen_string_literal: true

require 'test_helper'

class AppGroupsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @app_group = app_groups(:one)
  end

  test 'should get index' do
    get app_groups_url
    assert_response :success
  end

  test 'should get new' do
    get new_app_group_url
    assert_response :success
  end

  test 'should create app_group' do
    assert_difference('AppGroup.count') do
      post app_groups_url,
           params: { app_group: { group_description: @app_group.group_description, group_name: @app_group.group_name } }
    end

    assert_redirected_to app_group_url(AppGroup.last)
  end

  test 'should show app_group' do
    get app_group_url(@app_group)
    assert_response :success
  end

  test 'should get edit' do
    get edit_app_group_url(@app_group)
    assert_response :success
  end

  test 'should update app_group' do
    patch app_group_url(@app_group),
          params: { app_group: { group_description: @app_group.group_description, group_name: @app_group.group_name } }
    assert_redirected_to app_group_url(@app_group)
  end

  test 'should destroy app_group' do
    assert_difference('AppGroup.count', -1) do
      delete app_group_url(@app_group)
    end

    assert_redirected_to app_groups_url
  end
end
