# frozen_string_literal: true

# MRR contoroller
class DailyMrrsController < ApplicationController
  before_action :authenticate_user!, except: %i[api]
  before_action :set_daily_mrr, only: %i[show edit update destroy]
  skip_before_action :verify_authenticity_token, only: %i[api]

  # GET /daily_mrrs or /daily_mrrs.json
  def index
    @daily_mrrs = DailyMrr.all
  rescue NoMethodError => e
    Rollbar.info(e, @daily_mrr.errors)
  end

  # GET /daily_mrrs/1 or /daily_mrrs/1.json
  def show; end

  # GET /daily_mrrs/new
  def new
    @daily_mrr = DailyMrr.new
  end

  # GET /daily_mrrs/1/edit
  def edit; end

  # POST /daily_mrrs or /daily_mrrs.json
  def create
    @daily_mrr = DailyMrr.new(daily_mrr_params)

    respond_to do |format|
      if @daily_mrr.save
        format.html { redirect_to @daily_mrr, notice: 'Daily mrr was successfully created.' }
        format.json { render :show, status: :created, location: @daily_mrr }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @daily_mrr.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /daily_mrrs/1 or /daily_mrrs/1.json
  def update
    respond_to do |format|
      if @daily_mrr.update(daily_mrr_params)
        format.html { redirect_to @daily_mrr, notice: 'Daily mrr was successfully updated.' }
        format.json { render :show, status: :ok, location: @daily_mrr }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @daily_mrr.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /daily_mrrs/1 or /daily_mrrs/1.json
  def destroy
    @daily_mrr.destroy
    respond_to do |format|
      format.html { redirect_to daily_mrrs_url, notice: 'Daily mrr was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def api
    # @message = {}
    # @paid_mrr = params['_json'][0]
    # @trial_mrr = params['_json'][1]
    # @message["paid"] = @paid_mrr
    # @message["trial"] = @trial_mrr
    # @message["received"] = params

    render json: params
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_daily_mrr
    @daily_mrr = DailyMrr.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def daily_mrr_params
    params.require(:daily_mrr).permit(:app_id, :level, :amount)
  end
end
