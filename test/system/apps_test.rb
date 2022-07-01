# frozen_string_literal: true

require 'application_system_test_case'

class AppsTest < ApplicationSystemTestCase
  setup do
    @app = apps(:one)
  end

  test 'visiting the index' do
    visit apps_url
    assert_selector 'h1', text: 'Apps'
  end

  test 'creating a App' do
    visit apps_url
    click_on 'New App'

    fill_in 'Api key', with: @app.api_key
    fill_in 'App code', with: @app.app_code
    fill_in 'App name', with: @app.app_name
    fill_in 'Partner', with: @app.partner_id
    fill_in 'Secondary api key', with: @app.secondary_api_key
    click_on 'Create App'

    assert_text 'App was successfully created'
    click_on 'Back'
  end

  test 'updating a App' do
    visit apps_url
    click_on 'Edit', match: :first

    fill_in 'Api key', with: @app.api_key
    fill_in 'App code', with: @app.app_code
    fill_in 'App name', with: @app.app_name
    fill_in 'Partner', with: @app.partner_id
    fill_in 'Secondary api key', with: @app.secondary_api_key
    click_on 'Update App'

    assert_text 'App was successfully updated'
    click_on 'Back'
  end

  test 'destroying a App' do
    visit apps_url
    page.accept_confirm do
      click_on 'Destroy', match: :first
    end

    assert_text 'App was successfully destroyed'
  end
end
