# frozen_string_literal: true

require 'application_system_test_case'

class BlockersTest < ApplicationSystemTestCase
  setup do
    @blocker = blockers(:one)
  end

  test 'visiting the index' do
    visit blockers_url
    assert_selector 'h1', text: 'Blockers'
  end

  test 'creating a Blocker' do
    visit blockers_url
    click_on 'New Blocker'

    fill_in 'Added by', with: @blocker.added_by
    fill_in 'Item', with: @blocker.item
    click_on 'Create Blocker'

    assert_text 'Blocker was successfully created'
    click_on 'Back'
  end

  test 'updating a Blocker' do
    visit blockers_url
    click_on 'Edit', match: :first

    fill_in 'Added by', with: @blocker.added_by
    fill_in 'Item', with: @blocker.item
    click_on 'Update Blocker'

    assert_text 'Blocker was successfully updated'
    click_on 'Back'
  end

  test 'destroying a Blocker' do
    visit blockers_url
    page.accept_confirm do
      click_on 'Destroy', match: :first
    end

    assert_text 'Blocker was successfully destroyed'
  end
end
