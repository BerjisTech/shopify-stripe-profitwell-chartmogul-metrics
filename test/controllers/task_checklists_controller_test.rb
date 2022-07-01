# frozen_string_literal: true

require 'test_helper'

class TaskChecklistsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @task_checklist = task_checklists(:one)
  end

  test 'should get index' do
    get task_checklists_url
    assert_response :success
  end

  test 'should get new' do
    get new_task_checklist_url
    assert_response :success
  end

  test 'should create task_checklist' do
    assert_difference('TaskChecklist.count') do
      post task_checklists_url,
           params: { task_checklist: { added_by: @task_checklist.added_by, item: @task_checklist.item,
                                       status: @task_checklist.status, task_id: @task_checklist.task_id } }
    end

    assert_redirected_to task_checklist_url(TaskChecklist.last)
  end

  test 'should show task_checklist' do
    get task_checklist_url(@task_checklist)
    assert_response :success
  end

  test 'should get edit' do
    get edit_task_checklist_url(@task_checklist)
    assert_response :success
  end

  test 'should update task_checklist' do
    patch task_checklist_url(@task_checklist),
          params: { task_checklist: { added_by: @task_checklist.added_by, item: @task_checklist.item,
                                      status: @task_checklist.status, task_id: @task_checklist.task_id } }
    assert_redirected_to task_checklist_url(@task_checklist)
  end

  test 'should destroy task_checklist' do
    assert_difference('TaskChecklist.count', -1) do
      delete task_checklist_url(@task_checklist)
    end

    assert_redirected_to task_checklists_url
  end
end
