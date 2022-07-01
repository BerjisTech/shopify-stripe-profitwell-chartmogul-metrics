# frozen_string_literal: true

# Model
# rubocop:disable Metrics/MethodLength
# rubocop:disable Metrics/AbcSize
class Profitwell < ApplicationRecord
  T2G_ID = App.find_by(app_name: 'Text2Give').id
  def self.start_update
    t2g_data = OpenStruct.new Profitwell.plans
    DailyMrr.save_mrr(t2g_data, T2G_ID)
    DailyMrr.save_count(t2g_data.plans, T2G_ID, t2g_data)
    t2g_data
  end

  def self.load_customers
    path = 'https://api.profitwell.com/v2/customers/'
    header = {
      Authorization: Api.profitwell_api(T2G_ID).secret,
      'Content-Type': 'application/json'
    }
    get_from_path(path, [], header)
  end

  def self.status
    path = 'https://api.profitwell.com/v2/api-status/'
    header = {
      Authorization: Api.profitwell_api(T2G_ID).secret,
      'Content-Type': 'application/json'
    }
    get_from_path(path, [], header)
  end

  def self.plans
    secret = Api.profitwell_api(T2G_ID).secret
    path = 'https://api.profitwell.com/v2/metrics/plans/'
    header = {
      Authorization: secret,
      'Content-Type': 'application/json'
    }
    plans = OpenStruct.new JSON.parse(get_from_path(path, [], header))
    metrics(plans.plan_ids, secret)
  end

  def self.all_finance; end

  def self.metrics(plans, secret)
    metrics = []
    mrr = 0
    trial = 0
    plans.map do |plan|
      trial_users = 0
      path = "https://api.profitwell.com/v2/metrics/monthly/?plan_id=#{plan}&metrics="
      header = { Authorization: secret, 'Content-Type': 'application/json' }
      metric = OpenStruct.new JSON.parse(get_from_path(path, [], header))

      paying_mrr = OpenStruct.new metric.data['recurring_revenue'].last
      Metric.find_or_create_by(app_id: T2G_ID, net_revenue: paying_mrr)
      revenue_per_user = OpenStruct.new metric.data['average_revenue_per_user'].last
      paying_users = OpenStruct.new metric.data['active_customers'].last
      trial_data = if metric.data['active_trialing_customers'].present?
                     OpenStruct.new metric.data['active_trialing_customers'].last
                   end

      trial_users = trial_data.value if trial_data.present?
      number_of_users = trial_users + paying_users.value
      trial_mrr = revenue_per_user.value * trial_users

      metric_data = format_plan(plan, paying_mrr, number_of_users, trial_mrr)

      mrr += paying_mrr.value
      trial += trial_mrr
      metrics << metric_data
    end
    format_data(mrr, metrics)
  end

  def self.format_plan(plan, paying_mrr, number_of_users, trial_mrr)
    {
      id: plan,
      name: plan,
      price: paying_mrr.value,
      number_of_user: number_of_users,
      mrr_paying: paying_mrr.value,
      mrr_trial: trial_mrr
    }
  end

  def self.format_data(mrr, metrics)
    {
      current_time_stamp: DateTime.now.to_i,
      current_date: DateTime.now.strftime('%d-%m-%Y'),
      paying_mrr: mrr,
      trial_mrr: StripeDatum.stripe_trial(App.find(T2G_ID), {
                                            start: (Date.today - 24.hours),
                                            end: Date.today
                                          }),
      paying_arr: mrr * 12,
      plans: metrics
    }
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
end

# rubocop:enable Metrics/MethodLength
# rubocop:enable Metrics/AbcSize
