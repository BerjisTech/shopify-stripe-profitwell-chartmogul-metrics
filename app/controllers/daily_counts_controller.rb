# frozen_string_literal: true

class DailyCountsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_daily_count, only: %i[show edit update destroy]

  # GET /daily_counts or /daily_counts.json
  def index
    @daily_counts = DailyCount.where(app_id: session[:current_app])
  rescue NoMethodError => e
    Rollbar.info(e, @daily_counts.errors)
  end

  # GET /daily_counts/1 or /daily_counts/1.json
  def show; end

  # GET /daily_counts/new
  def new
    @daily_count = DailyCount.new
  end

  # GET /daily_counts/1/edit
  def edit; end

  # POST /daily_counts or /daily_counts.json
  def create
    @daily_count = DailyCount.new(daily_count_params)

    respond_to do |format|
      if @daily_count.save
        format.html { redirect_to @daily_count, notice: 'Daily count was successfully created.' }
        format.json { render :show, status: :created, location: @daily_count }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @daily_count.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /daily_counts/1 or /daily_counts/1.json
  def update
    respond_to do |format|
      if @daily_count.update(daily_count_params)
        format.html { redirect_to @daily_count, notice: 'Daily count was successfully updated.' }
        format.json { render :show, status: :ok, location: @daily_count }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @daily_count.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /daily_counts/1 or /daily_counts/1.json
  def destroy
    @daily_count.destroy
    respond_to do |format|
      format.html { redirect_to daily_counts_url, notice: 'Daily count was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_daily_count
    @daily_count = DailyCount.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def daily_count_params
    params.require(:daily_count).permit(:app_id, :user_count, :date, :plan_id)
  end
end
