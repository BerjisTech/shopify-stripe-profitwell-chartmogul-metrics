# frozen_string_literal: true

require 'application_system_test_case'

class TaskCommentsTest < ApplicationSystemTestCase
  setup do
    @task_comment = task_comments(:one)
  end

  test 'visiting the index' do
    visit task_comments_url
    assert_selector 'h1', text: 'Task Comments'
  end

  test 'creating a Task comment' do
    visit task_comments_url
    click_on 'New Task Comment'

    fill_in 'Comment', with: @task_comment.comment
    fill_in 'Task', with: @task_comment.task_id
    fill_in 'User', with: @task_comment.user_id
    click_on 'Create Task comment'

    assert_text 'Task comment was successfully created'
    click_on 'Back'
  end

  test 'updating a Task comment' do
    visit task_comments_url
    click_on 'Edit', match: :first

    fill_in 'Comment', with: @task_comment.comment
    fill_in 'Task', with: @task_comment.task_id
    fill_in 'User', with: @task_comment.user_id
    click_on 'Update Task comment'

    assert_text 'Task comment was successfully updated'
    click_on 'Back'
  end

  test 'destroying a Task comment' do
    visit task_comments_url
    page.accept_confirm do
      click_on 'Destroy', match: :first
    end

    assert_text 'Task comment was successfully destroyed'
  end
end
