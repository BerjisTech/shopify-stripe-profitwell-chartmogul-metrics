# frozen_string_literal: true

# MetricsController
# rubocop:disable Metrics/ClassLength
class MetricsController < ApplicationController
  before_action :authenticate_user!, except: %i[csv shopify_daily_data shopify_monthly_data shopify_emergency_data_fix]
  before_action :set_metric, only: %i[show edit update destroy]
  before_action :check_metric_level,
                only: %i[control_center metrics forecast customers benchmarks recover cancellations]

  SHOPIFY_APPS = [
    'Product Customizer',
    'In Cart Upsell',
    'TrackifyX',
    'Preorder Now',
    'Bulk Discount Now',
    'Wholesale Pricing Now',
    'Sticky Add To Cart Booster',
    'Preorderly',
    'Upselly',
    'Sales Rocket'
  ].freeze

  # GET /metrics or /metrics.json
  def index
    @metrics = Metric.all
  end

  def stripe
    app_id = App.find_by(app_name: params[:app]).id
    trials = []
    (0...90).map do |days|
      start_date = Date.today - (days + 1).days
      end_date = Date.today - days.days
      metrics = StripeDatum.initate_import(app_id, {
                                             start: start_date,
                                             end: end_date
                                           })
      mrr = DailyMrr.find_or_create_by(app_id: app_id, date: (Date.today - days.days).strftime('%d-%m-%Y'))
      DailyMrr.where(id: mrr.id).update_all(trial: metrics[:trials])
      trials << metrics
    end
    render json: trials
  end

  def playground
    app = App.find_by(tag: params[:app].upcase)
    trials = []
    (0...90).map do |days|
      p "Starting #{app.tag} metrics for #{(Date.today - days.days).strftime('%d-%m-%Y')}"
      start_date = Date.today - (days + 1).days
      end_date = Date.today - days.days
      trial_count = StripeDatum.playground(app, {
                                             start: start_date,
                                             end: end_date
                                           })

      p "Creating DailyMrr for #{app.app_name} on #{(Date.today - days.days).strftime('%d-%m-%Y')}"
      mrr = DailyMrr.find_or_create_by(app_id: app.id, date: (Date.today - days.days).strftime('%d-%m-%Y'))

      p "Update DailyMrr for #{app.app_name} on  #{(Date.today - days.days).strftime('%d-%m-%Y')} to #{trial_count}"
      DailyMrr.where(id: mrr.id).update_all(trial: trial_count)
      trials << trial_count
    end
    render json: trails
  end

  def control_center
    @metrics = Metric.all
  end

  def metrics; end

  def forecast; end

  def customers; end

  def benchmarks; end

  def recover; end

  def cancellations; end

  def cron
    SHOPIFY_APPS.map do |app|
      app_id = App.find_by(app_name: app).id
      ShopifyTimportJob.set(wait: 10.seconds).perform_later(app_id, 'user', 1, 0, 'day')
      ShopifyTimportJob.set(wait: 30.seconds).perform_later(app_id, 'financials', 1, 0, 'day')
      ShopifyTimportJob.set(wait: 50.seconds).perform_later(app_id, 'financials', 30, 0, 'month')
    end
    render json: {}
  end

  def shopify_daily_data
    time = { start: (DateTime.now - 1.days).to_s, end: DateTime.now.to_s, span: 'day' }

    time[:start] = (DateTime.now - params[:time_start].to_i.days).to_s if params[:time_start].present?
    time[:end] = (DateTime.now - params[:time_end].to_i.days).to_s if params[:time_end].present?

    render json: Shopify.run_importer(App.find_by(app_name: params[:app]), params[:data_set], time, '')
  end

  def shopify_monthly_data
    time = { start: (DateTime.now - 30.days).to_s, end: DateTime.now.to_s, span: 'month' }

    time[:start] = (DateTime.now - params[:time_start].to_i.days).to_s if params[:time_start].present?
    time[:end] = (DateTime.now - params[:time_end].to_i.days).to_s if params[:time_end].present?

    render json: Shopify.run_importer(App.find_by(app_name: params[:app]), params[:data_set], time, '')
  end

  def shopify_emergency_data_fix
    metrics = []
    data_set = params[:data_set]
    time = { start: (DateTime.now - 1.days).to_s, end: DateTime.now.to_s, span: 'day' }
    time[:start] = (DateTime.now - params[:time_start].to_i.days).to_s if params[:time_start].present?
    time[:end] = (DateTime.now - params[:time_end].to_i.days).to_s if params[:time_end].present?

    if params[:time_end].present? && params[:time_start].present?
      span = params[:time_end].to_i - params[:time_start].to_i
      time[:span] = 'month' if span >= 28 && span <= 31
    end

    render json: Shopify.run_importer(App.find_by(app_name: params[:app]), params[:data_set].to_s, time, '')
  end

  def shopify_emergency_data_fix_urls
    time = { start: 1, end: 0, span: 'day' }
    time[:start] = params[:time_start].to_i if params[:time_start].present?
    time[:end] = params[:time_end].to_i if params[:time_end].present?

    urls = []
    SHOPIFY_APPS.map do |app|
      urls << {
        today: "#{root_url}import/shopify_monthly_data/#{app}/#{params[:data_set]}",
        custom: "#{root_url}import/shopify_monthly_data/#{app}/#{params[:data_set]}/#{time[:start]}/#{time[:end]}"
      }
    end
    render json: urls
  end

  def csv
    app = params[:app]
    app_emails = Metric.csv_data(app)
    suppresion_list = Metric.suppresion_list(app)
    suppressed = Metric.suppressed(app_emails, suppresion_list)
    render json: { shopify_emails: app_emails.count, nikitas_list: suppresion_list.count,
                   suppressed_emails: suppressed }
  end

  # GET /metrics/1 or /metrics/1.json
  def show; end

  # GET /metrics/new
  def new
    @metric = Metric.new
  end

  # GET /metrics/1/edit
  def edit; end

  # POST /metrics or /metrics.json
  def create
    @metric = Metric.new(metric_params)

    respond_to do |format|
      if @metric.save
        format.html { redirect_to @metric, notice: 'Metric was successfully created.' }
        format.json { render :show, status: :created, location: @metric }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @metric.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /metrics/1 or /metrics/1.json
  def update
    respond_to do |format|
      if @metric.update(metric_params)
        format.html { redirect_to @metric, notice: 'Metric was successfully updated.' }
        format.json { render :show, status: :ok, location: @metric }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @metric.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /metrics/1 or /metrics/1.json
  def destroy
    @metric.destroy
    respond_to do |format|
      format.html { redirect_to metrics_url, notice: 'Metric was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  def check_metric_level
    @metric_level = if params[:app_id].present?
                      'App level'
                    elsif params[:fund].present?
                      'Fund level'
                    else
                      'Main company level'
                    end
  end

  # Use callbacks to share common setup or constraints between actions.
  def set_metric
    @metric = Metric.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def metric_params
    params.require(:metric).permit(:mrr, :net_revenue, :one_time_charge, :fees, :other_revenue, :avg_revenue_per_user,
                                   :arr, :ltv, :mrr_growth_rate, :user_churn, :revenue_churn, :quick_ratio,
                                   :active_customers, :new_customers, :reactivations, :deactivations,
                                   :new_subscriptions, :closed_subscription, :active_subscriptions,
                                   :upgrades, :downgrades, :churned_customers, :coupons_redeemed,
                                   :failed_charges, :refunds)
  end
end

# rubocop:enable Metrics/ClassLength
