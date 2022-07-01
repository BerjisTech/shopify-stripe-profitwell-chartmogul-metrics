# frozen_string_literal: true

require 'application_system_test_case'

class BigRocksTest < ApplicationSystemTestCase
  setup do
    @big_rock = big_rocks(:one)
  end

  test 'visiting the index' do
    visit big_rocks_url
    assert_selector 'h1', text: 'Big Rocks'
  end

  test 'creating a Big rock' do
    visit big_rocks_url
    click_on 'New Big Rock'

    fill_in 'Category', with: @big_rock.category
    fill_in 'Owner', with: @big_rock.owner
    fill_in 'Quater', with: @big_rock.quater
    fill_in 'Rock', with: @big_rock.rock
    fill_in 'Status', with: @big_rock.status
    click_on 'Create Big rock'

    assert_text 'Big rock was successfully created'
    click_on 'Back'
  end

  test 'updating a Big rock' do
    visit big_rocks_url
    click_on 'Edit', match: :first

    fill_in 'Category', with: @big_rock.category
    fill_in 'Owner', with: @big_rock.owner
    fill_in 'Quater', with: @big_rock.quater
    fill_in 'Rock', with: @big_rock.rock
    fill_in 'Status', with: @big_rock.status
    click_on 'Update Big rock'

    assert_text 'Big rock was successfully updated'
    click_on 'Back'
  end

  test 'destroying a Big rock' do
    visit big_rocks_url
    page.accept_confirm do
      click_on 'Destroy', match: :first
    end

    assert_text 'Big rock was successfully destroyed'
  end
end
