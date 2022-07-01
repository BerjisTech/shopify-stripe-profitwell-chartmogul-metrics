# frozen_string_literal: true

require 'application_system_test_case'

class DailyCountsTest < ApplicationSystemTestCase
  setup do
    @daily_count = daily_counts(:one)
  end

  test 'visiting the index' do
    visit daily_counts_url
    assert_selector 'h1', text: 'Daily Counts'
  end

  test 'creating a Daily count' do
    visit daily_counts_url
    click_on 'New Daily Count'

    fill_in 'App', with: @daily_count.app_id
    fill_in 'Date', with: @daily_count.date
    fill_in 'Plan', with: @daily_count.plan_id
    fill_in 'User count', with: @daily_count.user_count
    click_on 'Create Daily count'

    assert_text 'Daily count was successfully created'
    click_on 'Back'
  end

  test 'updating a Daily count' do
    visit daily_counts_url
    click_on 'Edit', match: :first

    fill_in 'App', with: @daily_count.app_id
    fill_in 'Date', with: @daily_count.date
    fill_in 'Plan', with: @daily_count.plan_id
    fill_in 'User count', with: @daily_count.user_count
    click_on 'Update Daily count'

    assert_text 'Daily count was successfully updated'
    click_on 'Back'
  end

  test 'destroying a Daily count' do
    visit daily_counts_url
    page.accept_confirm do
      click_on 'Destroy', match: :first
    end

    assert_text 'Daily count was successfully destroyed'
  end
end
