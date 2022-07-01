# frozen_string_literal: true

require 'test_helper'

class TaskStagesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @task_stage = task_stages(:one)
  end

  test 'should get index' do
    get task_stages_url
    assert_response :success
  end

  test 'should get new' do
    get new_task_stage_url
    assert_response :success
  end

  test 'should create task_stage' do
    assert_difference('TaskStage.count') do
      post task_stages_url, params: { task_stage: { stage: @task_stage.stage } }
    end

    assert_redirected_to task_stage_url(TaskStage.last)
  end

  test 'should show task_stage' do
    get task_stage_url(@task_stage)
    assert_response :success
  end

  test 'should get edit' do
    get edit_task_stage_url(@task_stage)
    assert_response :success
  end

  test 'should update task_stage' do
    patch task_stage_url(@task_stage), params: { task_stage: { stage: @task_stage.stage } }
    assert_redirected_to task_stage_url(@task_stage)
  end

  test 'should destroy task_stage' do
    assert_difference('TaskStage.count', -1) do
      delete task_stage_url(@task_stage)
    end

    assert_redirected_to task_stages_url
  end
end
