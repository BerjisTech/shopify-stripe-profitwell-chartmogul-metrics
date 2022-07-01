# frozen_string_literal: true

require 'csv'
# Metric Model
# rubocop:disable Metrics/MethodLength
class Metric < ApplicationRecord
  belongs_to :app
  # belongs_to :daily_mrr, touch: :date
  APPS = {
    'icu' => 'In Cart Upsell & Cross Sell',
    'pc' => 'Product Customizer',
    'pon' => 'Pre-Order Now - Preorder',
    'bdn' => 'Bulk Discounts Now',
    'wpn' => 'Wholesale Pricing Now',
    'trackify' => 'Trackify Facebook Pixel App',
    'sales-rocket' => 'Sales Rocket | many apps in 1',
    'sticky' => 'Sticky Add To Cart BOOSTER PRO',
    'upselly' => 'Upsell & Cross Sell â€¢ Upselly',
    'preorderly' => 'Preorderly â€¢ Pre-order PRO'
  }.freeze

  def self.net_revenue_on(date = Date.today, app_id)
    revenue = Metric.find_by(app_id: app_id, date: date)
    if revenue.nil?
      0.0
    else
      revenue.net_revenue.to_f
    end
  end

  def self.latest_net_revenue
    today = Date.today
    yesterday = (today - 1)

    today_net_revenue = Metric.where(date: today.strftime('%d-%m-%Y')).pluck('sum(net_revenue)').sum.to_f
    yesterday_net_revenue = Metric.where(date: yesterday.strftime('%d-%m-%Y')).pluck('sum(net_revenue)').sum.to_f

    if today_net_revenue.nil? || today_net_revenue.zero?
      number_with_precision(yesterday_net_revenue, precision: 2, delimiter: ',', separator: '.')
    else
      number_with_precision(today_net_revenue, precision: 2, delimiter: ',', separator: '.')
    end
  end

  def self.latest_arr
    today = Date.today
    yesterday = (today - 1)

    today_net_revenue = Metric.where(date: today.strftime('%d-%m-%Y')).pluck('sum(net_revenue)').sum.to_f
    yesterday_net_revenue = Metric.where(date: yesterday.strftime('%d-%m-%Y')).pluck('sum(net_revenue)').sum.to_f

    if today_net_revenue.nil? || today_net_revenue.zero?
      number_with_precision(yesterday_net_revenue * 12, precision: 2, delimiter: ',', separator: '.')
    else
      number_with_precision(today_net_revenue * 12, precision: 2, delimiter: ',', separator: '.')
    end
  end

  def self.latest_gross_mrr
    today = Date.today
    yesterday = (today - 1)

    today_mrr = Metric.where(date: today.strftime('%d-%m-%Y')).pluck('sum(mrr)').sum.to_f
    yesterday_mrr = Metric.where(date: yesterday.strftime('%d-%m-%Y')).pluck('sum(mrr)').sum.to_f

    if today_mrr.nil? || today_mrr.zero?
      number_with_precision(yesterday_mrr, precision: 2, delimiter: ',', separator: '.')
    else
      number_with_precision(today_mrr, precision: 2, delimiter: ',', separator: '.')
    end
  end

  def self.arpu
    today = Date.today
    yesterday = (today - 1)

    today_net_revenue = Metric.where(date: today.strftime('%d-%m-%Y')).pluck('sum(net_revenue)').sum.to_f
    yesterday_net_revenue = Metric.where(date: yesterday.strftime('%d-%m-%Y')).pluck('sum(net_revenue)').sum.to_f

    today_count = DailyCount.where(date: today.strftime('%d-%m-%Y')).pluck('sum(user_count)').sum.to_f
    yesterday_count = DailyCount.where(date: yesterday.strftime('%d-%m-%Y')).pluck('sum(user_count)').sum.to_f

    revenue = if today_net_revenue.nil? || today_net_revenue.zero?
                yesterday_net_revenue
              else
                today_net_revenue
              end

    users = if today_count.nil? || today_count.zero?
              yesterday_count
            else
              today_count
            end

    number_with_precision(revenue / users, precision: 2, delimiter: ',', separator: '.')
  end

  def self.net_revenue(app_id, date)
    revenue = Metric.find_by(app_id: app_id, date: date)

    if revenue.present?
      revenue.net_revenue.to_f
    else
      0.0
    end
  end

  def self.recurring_revenue
    end_date = Date.today
    start_date = (end_date - 30.days)

    recurring_revenue = Metric.where(date: start_date..end_date).pluck('sum(recurring_revenue)').sum.to_f

    number_with_precision(recurring_revenue, precision: 2, delimiter: ',', separator: '.')
  end

  def self.one_time_charge
    end_date = Date.today
    start_date = (end_date - 30.days)

    one_time_charge = Metric.where(date: start_date..end_date).pluck('sum(one_time_charge)').sum.to_f

    number_with_precision(one_time_charge, precision: 2, delimiter: ',', separator: '.')
  end

  def self.refunds
    end_date = Date.today
    start_date = (end_date - 30.days)

    refunds = Metric.where(date: start_date..end_date).pluck('sum(refunds)').sum.to_f

    number_with_precision(refunds, precision: 2, delimiter: ',', separator: '.')
  end

  def self.gross_on_date(date)
    gross = DailyMrr.where(date: date).pluck('sum(amount)').sum.to_f
    number_with_precision(gross, precision: 2, delimiter: ',', separator: '.')
  end

  def self.csv_data(file_name)
    rows = {}
    file = File.read("./app/csvs/#{file_name}.csv")
    csv = CSV.parse(file, headers: true)
    csv.each_with_index.map do |row, index|
      next unless index.positive?

      rows[row[1]] = row[2]
    end
    rows
  end

  def self.suppresion_list(app)
    rows = []
    file = File.read('./app/csvs/from_nikita.csv')
    csv = CSV.parse(file, headers: true)
    csv.each_with_index.map do |row, index|
      next unless index.positive?

      next unless row[12] == APPS[app]

      rows << {
        name: row[2],
        app: row[12]
      }
    end
    rows
  end

  def self.suppressed(app_emails_list, suppresion_list)
    emails = ''
    suppresion_list.map do |shop|
      shop = OpenStruct.new shop
      emails += "#{app_emails_list[shop.name]},#{app_emails_list[shop.name]}\n"
    end
    "name,email\n#{emails}"
  end

  def self.stripe_user_data(app_id, date_start, date_end)
    api = Api.find_by(app_id: app_id, name: 'Stripe')

    publishable_key = api.key
    secret_key = api.secret

    Stripe.api_key = secret_key

    users = Stripe::Customer.list({ limit: 100_000,
                                    created: { gt: date_start.to_time.to_i, lte: date_end.to_time.to_i } })
    trial_count = 0
    cancelations = 0
    subscribe_count = 0
    premium_revenue = 0
    total_revenue = 0

    users.map do |user|
      next unless user['subscriptions'].present?
      next unless user.subscriptions.data.first.present?

      cancelled = user.subscriptions.data.first.cancel_at
      trial_end = user.subscriptions.data.first.trial_end
      status = user.subscriptions.data.first.status
      subscribe_count += 1 if cancelled.nil? && status == 'active'
      trial_count += 1 if  cancelled.nil? && status != 'active'
      cancelations += 1 unless cancelled.nil?
      price = user.subscriptions.data.first.items.data.first.price.unit_amount / 100
      premium_revenue += price if cancelled.nil? && status == 'active'
      total_revenue += price
    end

    {
      span: "#{date_start} - #{date_end}",
      subscriptions: subscribe_count,
      cancelations: cancelations,
      trials: trial_count,
      total_customers: users.count,
      premium_revenue: premium_revenue,
      trials_revenue: total_revenue - premium_revenue
    }
  end

  def self.stripe_subscription_data(app_id, date_start, date_end)
    api = Api.find_by(app_id: app_id, name: 'Stripe')

    publishable_key = api.key
    secret_key = api.secret

    Stripe.api_key = secret_key

    subscriptions = Stripe::Subscription.list({ limit: 100_000,
                                                created: { gt: date_start.to_time.to_i,
                                                           lte: date_end.to_time.to_i } }).data

    premium = 0
    trials = 0
    trial_count = 0
    premium_count = 0

    subscriptions.map do |subscription|
      # next unless subscription.data.first.present?
      price = subscription.items.data.first.price.unit_amount / 100
      trials += price if subscription.status == 'trialing'
      premium += price if subscription.status == 'active'
      trial_count += 1 if subscription.status == 'trialing'
      premium_count += 1 if subscription.status == 'active'
    end

    {
      span: "#{date_start} - #{date_end}",
      subscriptions: subscriptions.count,
      trials: trials,
      premium: premium,
      trial_count: trial_count,
      premium_count: premium_count
    }
  end

  def self.stripe_payouts_data(app_id, _date_start, _date_end)
    api = Api.find_by(app_id: app_id, name: 'Stripe')

    publishable_key = api.key
    secret_key = api.secret

    Stripe.api_key = secret_key

    payouts = Stripe::Payout.list({ limit: 10 }).data
    total = 0

    payouts.map do |payout|
      total += (payout.amount / 100) if payout.status == 'paid'
    end

    total
  end

  def self.get_from_path(path, body = [], header = [])
    data = Faraday.get(path, body, header)

    data.body
  end

  def self.post_from_path(path, body)
    headers = {
      'Accept': 'application/json',
      'Content-Type': 'application/json'
    }
    Faraday.post(path, body.to_json, headers)
  end

  def self.format_stripe_users(users, time)
    trial_count = 0
    cancelations = 0
    subscribe_count = 0
    premium_revenue = 0
    total_revenue = 0

    users.map do |user|
      next unless user['subscriptions'].present?
      next unless user.subscriptions.data.first.present?

      cancelled = user.subscriptions.data.first.cancel_at
      trial_end = user.subscriptions.data.first.trial_end
      status = user.subscriptions.data.first.status
      subscribe_count += 1 if cancelled.nil? && status == 'active'
      trial_count += 1 if cancelled.nil? && status == 'trialing'
      cancelations += 1 unless cancelled.nil?
      price = user.subscriptions.data.first.items.data.first.price.unit_amount / 100
      premium_revenue += price if cancelled.nil? && status == 'active'
      total_revenue += price
    end

    {
      span: "#{time[:start]} - #{time[:end]}",
      subscriptions: subscribe_count,
      cancelations: cancelations,
      trials: trial_count,
      total_customers: users.count,
      premium_revenue: premium_revenue,
      trials_revenue: total_revenue - premium_revenue
      # customers: users
    }
  end
end

# rubocop:enable Metrics/MethodLength
