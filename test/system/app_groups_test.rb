# frozen_string_literal: true

require 'application_system_test_case'

class AppGroupsTest < ApplicationSystemTestCase
  setup do
    @app_group = app_groups(:one)
  end

  test 'visiting the index' do
    visit app_groups_url
    assert_selector 'h1', text: 'App Groups'
  end

  test 'creating a App group' do
    visit app_groups_url
    click_on 'New App Group'

    fill_in 'Group description', with: @app_group.group_description
    fill_in 'Group name', with: @app_group.group_name
    click_on 'Create App group'

    assert_text 'App group was successfully created'
    click_on 'Back'
  end

  test 'updating a App group' do
    visit app_groups_url
    click_on 'Edit', match: :first

    fill_in 'Group description', with: @app_group.group_description
    fill_in 'Group name', with: @app_group.group_name
    click_on 'Update App group'

    assert_text 'App group was successfully updated'
    click_on 'Back'
  end

  test 'destroying a App group' do
    visit app_groups_url
    page.accept_confirm do
      click_on 'Destroy', match: :first
    end

    assert_text 'App group was successfully destroyed'
  end
end
