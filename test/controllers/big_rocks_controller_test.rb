# frozen_string_literal: true

require 'test_helper'

class BigRocksControllerTest < ActionDispatch::IntegrationTest
  setup do
    @big_rock = big_rocks(:one)
  end

  test 'should get index' do
    get big_rocks_url
    assert_response :success
  end

  test 'should get new' do
    get new_big_rock_url
    assert_response :success
  end

  test 'should create big_rock' do
    assert_difference('BigRock.count') do
      post big_rocks_url,
           params: { big_rock: { category: @big_rock.category, owner: @big_rock.owner, quater: @big_rock.quater,
                                 rock: @big_rock.rock, status: @big_rock.status } }
    end

    assert_redirected_to big_rock_url(BigRock.last)
  end

  test 'should show big_rock' do
    get big_rock_url(@big_rock)
    assert_response :success
  end

  test 'should get edit' do
    get edit_big_rock_url(@big_rock)
    assert_response :success
  end

  test 'should update big_rock' do
    patch big_rock_url(@big_rock),
          params: { big_rock: { category: @big_rock.category, owner: @big_rock.owner, quater: @big_rock.quater,
                                rock: @big_rock.rock, status: @big_rock.status } }
    assert_redirected_to big_rock_url(@big_rock)
  end

  test 'should destroy big_rock' do
    assert_difference('BigRock.count', -1) do
      delete big_rock_url(@big_rock)
    end

    assert_redirected_to big_rocks_url
  end
end
