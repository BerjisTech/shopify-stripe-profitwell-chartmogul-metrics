# frozen_string_literal: true

require 'test_helper'

class TaskFollowersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @task_follower = task_followers(:one)
  end

  test 'should get index' do
    get task_followers_url
    assert_response :success
  end

  test 'should get new' do
    get new_task_follower_url
    assert_response :success
  end

  test 'should create task_follower' do
    assert_difference('TaskFollower.count') do
      post task_followers_url,
           params: { task_follower: { task_id: @task_follower.task_id, user_id: @task_follower.user_id } }
    end

    assert_redirected_to task_follower_url(TaskFollower.last)
  end

  test 'should show task_follower' do
    get task_follower_url(@task_follower)
    assert_response :success
  end

  test 'should get edit' do
    get edit_task_follower_url(@task_follower)
    assert_response :success
  end

  test 'should update task_follower' do
    patch task_follower_url(@task_follower),
          params: { task_follower: { task_id: @task_follower.task_id, user_id: @task_follower.user_id } }
    assert_redirected_to task_follower_url(@task_follower)
  end

  test 'should destroy task_follower' do
    assert_difference('TaskFollower.count', -1) do
      delete task_follower_url(@task_follower)
    end

    assert_redirected_to task_followers_url
  end
end
