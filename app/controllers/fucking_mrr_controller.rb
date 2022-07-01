# frozen_string_literal: true

# Fucking controller
class FuckingMrrController < ApplicationController
  def get
    get_data = DailyMrr.get_from_path(params[:path])
    DailyMrr.data_format(get_data, params[:app])
    render json: get_data
  end

  def post
    body = { shop: { date_min: '', date_max: '' } }
    post_data = DailyMrr.post_from_path(params[:path], body)
    data = post_data.body
    DailyMrr.data_format(data, params[:app])
    render json: post_data
  end

  def stupidification
    DailyMrr.fetch_mrr
    render json: Time.now
  end
end
