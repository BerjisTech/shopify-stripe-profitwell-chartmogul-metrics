# frozen_string_literal: true

require 'test_helper'

class AdminControllerTest < ActionDispatch::IntegrationTest
  test 'should get roles' do
    get admin_roles_url
    assert_response :success
  end
end
