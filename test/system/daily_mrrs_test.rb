# frozen_string_literal: true

require 'application_system_test_case'

class DailyMrrsTest < ApplicationSystemTestCase
  setup do
    @daily_mrr = daily_mrrs(:one)
  end

  test 'visiting the index' do
    visit daily_mrrs_url
    assert_selector 'h1', text: 'Daily Mrrs'
  end

  test 'creating a Daily mrr' do
    visit daily_mrrs_url
    click_on 'New Daily Mrr'

    fill_in 'Amount', with: @daily_mrr.amount
    fill_in 'App', with: @daily_mrr.app_id
    fill_in 'Level', with: @daily_mrr.level
    click_on 'Create Daily mrr'

    assert_text 'Daily mrr was successfully created'
    click_on 'Back'
  end

  test 'updating a Daily mrr' do
    visit daily_mrrs_url
    click_on 'Edit', match: :first

    fill_in 'Amount', with: @daily_mrr.amount
    fill_in 'App', with: @daily_mrr.app_id
    fill_in 'Level', with: @daily_mrr.level
    click_on 'Update Daily mrr'

    assert_text 'Daily mrr was successfully updated'
    click_on 'Back'
  end

  test 'destroying a Daily mrr' do
    visit daily_mrrs_url
    page.accept_confirm do
      click_on 'Destroy', match: :first
    end

    assert_text 'Daily mrr was successfully destroyed'
  end
end
