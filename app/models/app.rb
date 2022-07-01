# frozen_string_literal: true

# Model
class App < ApplicationRecord
  belongs_to :app_group
  has_many :daily_counts
  has_many :daily_mrrs
  has_many :plans
  has_many :metrics

  def self.tag(app_id)
    if app_id.present?
      app = App.find(app_id)

      "<code class='text-success'>[#{app.tag}]</code>" if app.present?
    else
      '<span></span>'
    end
  end

  def self.owners(app_id)
    Owner.where(app_id: app_id)
  end

  def self.mine(user_id)
    Owner.where(user_id: user_id).select(:app_id)
  end

  def self.latest_app_mrr(app_id)
    today = Date.today
    yesterday = (today - 1)

    today_mrr = DailyMrr.where(app_id: app_id, date: today.strftime('%d-%m-%Y')).pluck(:amount).first.to_f
    yesterday_mrr = DailyMrr.where(app_id: app_id, date: yesterday.strftime('%d-%m-%Y')).pluck(:amount).first.to_f

    if today_mrr.nil? || today_mrr.zero?
      yesterday_mrr
    else
      today_mrr
    end
  end

  def self.latest_app_trial_mrr(app_id)
    today = Date.today
    yesterday = (today - 1)

    today_mrr = DailyMrr.where(app_id: app_id, date: today.strftime('%d-%m-%Y')).pluck(:trial).first.to_f
    yesterday_mrr = DailyMrr.where(app_id: app_id, date: yesterday.strftime('%d-%m-%Y')).pluck(:trial).first.to_f

    if today_mrr.nil? || today_mrr.zero?
      yesterday_mrr
    else
      today_mrr
    end
  end

  def self.latest_app_users(app_id)
    today = Date.today
    yesterday = (today - 1)

    today_count = DailyCount.where(app_id: app_id, date: today.strftime('%d-%m-%Y')).pluck('sum(user_count)').sum.to_f
    yesterday_count = DailyCount.where(app_id: app_id,
                                       date: yesterday.strftime('%d-%m-%Y')).pluck('sum(user_count)').sum.to_f

    if today_count.nil? || today_count.zero?
      yesterday_count
    else
      today_count
    end
  end

  def self.net_revenue(app_id)
    today = Date.today
    yesterday = (today - 1)

    today_net_revenue = Metric.where(app_id: app_id,
                                     date: today.strftime('%d-%m-%Y')).pluck('sum(net_revenue)').sum.to_f
    yesterday_net_revenue = Metric.where(app_id: app_id,
                                         date: yesterday.strftime('%d-%m-%Y')).pluck('sum(net_revenue)').sum.to_f

    if today_net_revenue.nil? || today_net_revenue.zero?
      number_with_precision(yesterday_net_revenue, precision: 2, delimiter: ',', separator: '.')
    else
      number_with_precision(today_net_revenue, precision: 2, delimiter: ',', separator: '.')
    end
  end

  def self.last_metric_update(app_id)
    updates = Metric.where(app_id: app_id).order(created_at: :DESC)

    if updates.nil? || updates.last.nil?
      'never'
    else
      updates.last.created_at.strftime("%a, %b #{updates.last.created_at.day.ordinalize} %Y")
    end
  end

  def self.graph_metric(app_id, from, to); end
end
