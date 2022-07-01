# frozen_string_literal: true

# Model
# rubocop:disable Metrics/MethodLength
class Chartmogul < ApplicationRecord
  def self.start_update
    Qt.start_update
    Sk.start_update
  end

  def self.all_metrics
    ChartMogul::Metrics.all(start_date: dates.start_date,
                            end_date: dates.end_date, interval: 'month')
  end

  def self.users_last_30_days
    users = ChartMogul::Metrics.customer_count(start_date: dates.start_date,
                                               end_date: dates.end_date, interval: 'month')
    users.last.customers
  end

  def self.plan_user_count(plan)
    users = ChartMogul::Metrics.customer_count(start_date: dates.start_date,
                                               end_date: dates.end_date, interval: 'month', plans: plan)
    users.last.customers
  end

  def self.plan_mrr(plan)
    mrr = ChartMogul::Metrics.mrr(start_date: dates.start_date,
                                  end_date: dates.end_date, interval: 'month', plans: plan)
    (mrr.last.mrr / 100).round(2)
  end

  def self.mrr_last_30_days
    mrr = ChartMogul::Metrics.mrr(start_date: dates.start_date,
                                  end_date: dates.end_date, interval: 'month')
    (mrr.last.mrr / 100).round(2)
  end

  def self.arr_last_30_days
    arr = ChartMogul::Metrics.arr(start_date: dates.start_date,
                                  end_date: dates.end_date, interval: 'month')
    (arr.last.arr / 100).round(2)
  end

  def self.plans(app_id)
    plans = ChartMogul::Plan.all
    users = Chartmogul.users_last_30_days
    plan_count = plans.count
    plan_users = users / plan_count

    plans.map do |plan|
      format_plan(plan, plan_users, app_id)
    end
  end

  def self.format_data(app_id)
    paying_mrr = Chartmogul.mrr_last_30_days
    Metric.find_or_create_by(app_id: app_id, net_revenue: paying_mrr)
    {
      current_time_stamp: DateTime.now.to_i,
      current_date: DateTime.now.strftime('%d-%m-%Y'),
      paying_mrr: paying_mrr,
      trial_mrr: StripeDatum.stripe_trial(App.find(app_id), {
                                            start: (Date.today - 24.hours),
                                            end: Date.today
                                          }),
      total_users: Chartmogul.users_last_30_days,
      paying_arr: Chartmogul.arr_last_30_days,
      plans: Chartmogul.plans(app_id)
    }
  end

  def self.format_plan(plan, plan_users, _app_id)
    if plan.name.include? ','
      plan_mrr = 0
    else
      plan_mrr = Chartmogul.plan_mrr(plan.name)
      plan_users = Chartmogul.plan_user_count(plan.name)
    end
    {
      id: plan.uuid,
      name: plan.name,
      price: 0,
      number_of_user: plan_users.to_i,
      mrr_paying: plan_mrr.to_f,
      mrr_trial: 0
    }
  end

  def self.dates
    end_date = Date.today
    start_date = (end_date - 30)
    dates = {
      start_date: start_date.strftime('%Y-%m-%d'),
      end_date: end_date.strftime('%Y-%m-%d')
    }
    OpenStruct.new dates
  end
end

# rubocop:enable Metrics/MethodLength
