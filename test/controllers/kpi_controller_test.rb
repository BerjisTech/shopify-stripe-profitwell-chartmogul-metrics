# frozen_string_literal: true

require 'test_helper'

class KpiControllerTest < ActionDispatch::IntegrationTest
  test 'should get data' do
    get kpi_data_url
    assert_response :success
  end
end
