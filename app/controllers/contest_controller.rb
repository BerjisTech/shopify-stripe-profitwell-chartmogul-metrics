# frozen_string_literal: true

# Contest Controller
class ContestController < ApplicationController
  before_action :authenticate_user!
  before_action :set_reps

  def index
    # render json: @reps
  end

  def new
    render json: Contest.check_new_prices(params[:contest])
  end

  private

  def set_reps
    @y = Date.today.strftime('%Y').to_i
    @m = Date.today.strftime('%m').to_i
    @d = Date.today.strftime('%d').to_i
    @reps = Account.reps
    @weeks = Date.today.week_split
    @this_month = Date.today.strftime('%B')
  end

  def contest_params
    params.require(:contest).permit(:request_price, :received_price, :chat_price, :call_price, :app_id, :platform_id,
                                    :period_start, :period_end)
  end
end
