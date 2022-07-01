# frozen_string_literal: true

class MockupController < ApplicationController
  before_action :authenticate_user!

  def apps; end

  def app; end

  def businesses; end

  def business; end

  def control_center; end

  def metrics; end
end
