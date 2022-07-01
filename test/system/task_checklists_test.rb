# frozen_string_literal: true

require 'application_system_test_case'

class TaskChecklistsTest < ApplicationSystemTestCase
  setup do
    @task_checklist = task_checklists(:one)
  end

  test 'visiting the index' do
    visit task_checklists_url
    assert_selector 'h1', text: 'Task Checklists'
  end

  test 'creating a Task checklist' do
    visit task_checklists_url
    click_on 'New Task Checklist'

    fill_in 'Added by', with: @task_checklist.added_by
    fill_in 'Item', with: @task_checklist.item
    fill_in 'Status', with: @task_checklist.status
    fill_in 'Task', with: @task_checklist.task_id
    click_on 'Create Task checklist'

    assert_text 'Task checklist was successfully created'
    click_on 'Back'
  end

  test 'updating a Task checklist' do
    visit task_checklists_url
    click_on 'Edit', match: :first

    fill_in 'Added by', with: @task_checklist.added_by
    fill_in 'Item', with: @task_checklist.item
    fill_in 'Status', with: @task_checklist.status
    fill_in 'Task', with: @task_checklist.task_id
    click_on 'Update Task checklist'

    assert_text 'Task checklist was successfully updated'
    click_on 'Back'
  end

  test 'destroying a Task checklist' do
    visit task_checklists_url
    page.accept_confirm do
      click_on 'Destroy', match: :first
    end

    assert_text 'Task checklist was successfully destroyed'
  end
end
