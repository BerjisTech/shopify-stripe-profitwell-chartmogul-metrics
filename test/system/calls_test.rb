# frozen_string_literal: true

require 'application_system_test_case'

class CallsTest < ApplicationSystemTestCase
  setup do
    @call = calls(:one)
  end

  test 'visiting the index' do
    visit calls_url
    assert_selector 'h1', text: 'Calls'
  end

  test 'creating a Call' do
    visit calls_url
    click_on 'New Call'

    fill_in 'App', with: @call.app_id
    fill_in 'Comment', with: @call.comment
    fill_in 'Date', with: @call.date
    fill_in 'Ticket', with: @call.ticket
    fill_in 'User', with: @call.user_id
    click_on 'Create Call'

    assert_text 'Call was successfully created'
    click_on 'Back'
  end

  test 'updating a Call' do
    visit calls_url
    click_on 'Edit', match: :first

    fill_in 'App', with: @call.app_id
    fill_in 'Comment', with: @call.comment
    fill_in 'Date', with: @call.date
    fill_in 'Ticket', with: @call.ticket
    fill_in 'User', with: @call.user_id
    click_on 'Update Call'

    assert_text 'Call was successfully updated'
    click_on 'Back'
  end

  test 'destroying a Call' do
    visit calls_url
    page.accept_confirm do
      click_on 'Destroy', match: :first
    end

    assert_text 'Call was successfully destroyed'
  end
end
