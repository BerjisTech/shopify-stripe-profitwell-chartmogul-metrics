# frozen_string_literal: true

# Apps
class AppsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_app, only: %i[show edit update destroy]
  before_action :fetch_data, only: %i[show]

  # GET /apps or /apps.json
  def index
    @apps = App.joins(:app_group).select(:id, :app_name, :app_code, :partner_id, :api_key, :secondary_api_key,
                                         :group_name, :app_group_id, :created_at, :updated_at)
  rescue NoMethodError => e
    Rollbar.info(e, @apps.errors)
  end

  # GET /apps/1 or /apps/1.json
  def show
    # render json: @plan_count
  end

  # GET /apps/new
  def new
    @app = App.new
  end

  # GET /apps/1/edit
  def edit; end

  # POST /apps or /apps.json
  def create
    @app = App.new(app_params)

    respond_to do |format|
      if @app.save
        format.html { redirect_to @app, notice: 'App was successfully created.' }
        format.json { render :show, status: :created, location: @app }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @app.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /apps/1 or /apps/1.json
  def update
    respond_to do |format|
      if @app.update(app_params)
        format.html { redirect_to @app, notice: 'App was successfully updated.' }
        format.json { render :show, status: :ok, location: @app }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @app.errors, status: :unprocessable_entity }
      end
    end
  end

  def bar_graph_data
    if params[:app_id].blank? || params[:from].blank? || params[:to].blank?
      output = {
        type: 'error',
        message: 'Some attributes are missing'
      }
    else
      app_id = params[:app_id]
      from = params[:from]
      to = params[:to]

      metric = DailyMrr.where(app_id: app_id,
                              date: Date.today - from.to_i.days..Date.today - to.to_i.days).order(date: :desc).reverse
      if metric.count.positive?
        output = {
          type: 'data',
          data: format_for_bar_graph(metric)
        }
      else
        @start_date = Date.today - from.to_i.days
        @end_date = Date.today - to.to_i.days
        output = {
          type: 'info',
          message: "You have no metric records between
                    <span class='text-info'>#{@start_date.strftime("%A #{@start_date.day.ordinalize}, %B %Y")}</span>
                    and
                    <span class='text-info'>#{@end_date.strftime("%A #{@end_date.day.ordinalize}, %B %Y")}</span>"
        }
      end
    end

    render json: output
  end

  def format_for_bar_graph(metrics)
    output = []
    metrics.map do |metric|
      output << {
        y: metric.date.strftime('%Y-%m-%d'),
        a: metric.amount.round(2),
        b: metric.trial.round(2)
      }
    end
    output
  end

  # DELETE /apps/1 or /apps/1.json
  def destroy
    @app.destroy
    respond_to do |format|
      format.html { redirect_to apps_url, notice: 'App was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_app
    @app = App.find(params[:id])
    session[:current_app] = @app.id
  end

  def fetch_data
    fetch_users
    fetch_financials
    fetch_plans
    fetch_other_metrics
  end

  def fetch_other_metrics # rubocop:disable Metrics/AbcSize
    @review_count = Review.where(app_id: session[:current_app]).where('received_on > ?', 7.days.ago).count.to_i
    @calls_count = Call.where(app_id: session[:current_app]).where('date > ?', 7.days.ago).count.to_i
    @chats_count = Chat.where(app_id: session[:current_app]).where('date > ?', 7.days.ago).count.to_i
  end

  def fetch_financials
    @plans = Plan.where(app_id: session[:current_app]).count
    @mrr = DailyMrr.where(app_id: session[:current_app]).order(date: :desc).limit(30).reverse
  end

  def fetch_users
    @users = DailyCount.where(app_id: session[:current_app]).order(date: :desc).limit(30)
                       .select('sum(user_count) as total_count').group(:date).reverse
    @member_count = Owner.where(app_id: session[:current_app]).count
  end

  def fetch_plans # rubocop:disable Metrics/MethodLength
    @plan_count = Plan.where(app_id: session[:current_app]).order('created_at ASC')
    @daily_count = []
    @plan_count.map do |plan|
      count = DailyCount.where(plan_id: plan.id).last
      if count.present?
        count_paying = count.paying
        count_user = count.user_count
      else
        count_paying = 0
        count_user = 0
      end
      @daily_count << { name: plan.name, amount: count_paying, user_count: count_user }
    end
  end

  # Only allow a list of trusted parameters through.
  def app_params
    params.require(:app).permit(:app_name, :app_code, :partner_id, :api_key, :secondary_api_key, :app_group_id,
                                :data_point, :trial, :tag)
  end
end
