# frozen_string_literal: true

require 'test_helper'

class BlockersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @blocker = blockers(:one)
  end

  test 'should get index' do
    get blockers_url
    assert_response :success
  end

  test 'should get new' do
    get new_blocker_url
    assert_response :success
  end

  test 'should create blocker' do
    assert_difference('Blocker.count') do
      post blockers_url, params: { blocker: { added_by: @blocker.added_by, item: @blocker.item } }
    end

    assert_redirected_to blocker_url(Blocker.last)
  end

  test 'should show blocker' do
    get blocker_url(@blocker)
    assert_response :success
  end

  test 'should get edit' do
    get edit_blocker_url(@blocker)
    assert_response :success
  end

  test 'should update blocker' do
    patch blocker_url(@blocker), params: { blocker: { added_by: @blocker.added_by, item: @blocker.item } }
    assert_redirected_to blocker_url(@blocker)
  end

  test 'should destroy blocker' do
    assert_difference('Blocker.count', -1) do
      delete blocker_url(@blocker)
    end

    assert_redirected_to blockers_url
  end
end
