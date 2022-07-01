# frozen_string_literal: true

require 'application_system_test_case'

class TaskFollowersTest < ApplicationSystemTestCase
  setup do
    @task_follower = task_followers(:one)
  end

  test 'visiting the index' do
    visit task_followers_url
    assert_selector 'h1', text: 'Task Followers'
  end

  test 'creating a Task follower' do
    visit task_followers_url
    click_on 'New Task Follower'

    fill_in 'Task', with: @task_follower.task_id
    fill_in 'User', with: @task_follower.user_id
    click_on 'Create Task follower'

    assert_text 'Task follower was successfully created'
    click_on 'Back'
  end

  test 'updating a Task follower' do
    visit task_followers_url
    click_on 'Edit', match: :first

    fill_in 'Task', with: @task_follower.task_id
    fill_in 'User', with: @task_follower.user_id
    click_on 'Update Task follower'

    assert_text 'Task follower was successfully updated'
    click_on 'Back'
  end

  test 'destroying a Task follower' do
    visit task_followers_url
    page.accept_confirm do
      click_on 'Destroy', match: :first
    end

    assert_text 'Task follower was successfully destroyed'
  end
end
