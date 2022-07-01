# frozen_string_literal: true

require 'application_system_test_case'

class TaskStagesTest < ApplicationSystemTestCase
  setup do
    @task_stage = task_stages(:one)
  end

  test 'visiting the index' do
    visit task_stages_url
    assert_selector 'h1', text: 'Task Stages'
  end

  test 'creating a Task stage' do
    visit task_stages_url
    click_on 'New Task Stage'

    fill_in 'Stage', with: @task_stage.stage
    click_on 'Create Task stage'

    assert_text 'Task stage was successfully created'
    click_on 'Back'
  end

  test 'updating a Task stage' do
    visit task_stages_url
    click_on 'Edit', match: :first

    fill_in 'Stage', with: @task_stage.stage
    click_on 'Update Task stage'

    assert_text 'Task stage was successfully updated'
    click_on 'Back'
  end

  test 'destroying a Task stage' do
    visit task_stages_url
    page.accept_confirm do
      click_on 'Destroy', match: :first
    end

    assert_text 'Task stage was successfully destroyed'
  end
end
