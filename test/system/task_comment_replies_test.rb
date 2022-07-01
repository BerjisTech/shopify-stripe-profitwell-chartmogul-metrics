# frozen_string_literal: true

require 'application_system_test_case'

class TaskCommentRepliesTest < ApplicationSystemTestCase
  setup do
    @task_comment_reply = task_comment_replies(:one)
  end

  test 'visiting the index' do
    visit task_comment_replies_url
    assert_selector 'h1', text: 'Task Comment Replies'
  end

  test 'creating a Task comment reply' do
    visit task_comment_replies_url
    click_on 'New Task Comment Reply'

    fill_in 'Reply', with: @task_comment_reply.reply
    fill_in 'Task comment', with: @task_comment_reply.task_comment_id
    fill_in 'Task', with: @task_comment_reply.task_id
    fill_in 'User', with: @task_comment_reply.user_id
    click_on 'Create Task comment reply'

    assert_text 'Task comment reply was successfully created'
    click_on 'Back'
  end

  test 'updating a Task comment reply' do
    visit task_comment_replies_url
    click_on 'Edit', match: :first

    fill_in 'Reply', with: @task_comment_reply.reply
    fill_in 'Task comment', with: @task_comment_reply.task_comment_id
    fill_in 'Task', with: @task_comment_reply.task_id
    fill_in 'User', with: @task_comment_reply.user_id
    click_on 'Update Task comment reply'

    assert_text 'Task comment reply was successfully updated'
    click_on 'Back'
  end

  test 'destroying a Task comment reply' do
    visit task_comment_replies_url
    page.accept_confirm do
      click_on 'Destroy', match: :first
    end

    assert_text 'Task comment reply was successfully destroyed'
  end
end
