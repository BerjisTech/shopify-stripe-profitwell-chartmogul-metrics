# frozen_string_literal: true

require 'application_system_test_case'

class SlacksTest < ApplicationSystemTestCase
  setup do
    @slack = slacks(:one)
  end

  test 'visiting the index' do
    visit slacks_url
    assert_selector 'h1', text: 'Slacks'
  end

  test 'creating a Slack' do
    visit slacks_url
    click_on 'New Slack'

    fill_in 'Event', with: @slack.event
    click_on 'Create Slack'

    assert_text 'Slack was successfully created'
    click_on 'Back'
  end

  test 'updating a Slack' do
    visit slacks_url
    click_on 'Edit', match: :first

    fill_in 'Event', with: @slack.event
    click_on 'Update Slack'

    assert_text 'Slack was successfully updated'
    click_on 'Back'
  end

  test 'destroying a Slack' do
    visit slacks_url
    page.accept_confirm do
      click_on 'Destroy', match: :first
    end

    assert_text 'Slack was successfully destroyed'
  end
end
