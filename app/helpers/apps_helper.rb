# frozen_string_literal: true

module AppsHelper
  def today_mrr_data(app_id)
    today = Date.today
    yesterday = (today - 1)

    today_mrr = DailyMrr.where(app_id: app_id, date: today.strftime('%d-%m-%Y')).pluck('sum(amount)').sum.to_f
    yesterday_mrr = DailyMrr.where(app_id: app_id, date: yesterday.strftime('%d-%m-%Y')).pluck('sum(amount)').sum.to_f

    if today_mrr.nil? || today_mrr.zero?
      number_with_precision(yesterday_mrr, precision: 2, delimiter: ',', separator: '.')
    else
      number_with_precision(today_mrr, precision: 2, delimiter: ',', separator: '.')
    end
  end

  def today_trial_data(app_id)
    today = Date.today
    yesterday = (today - 1)

    today_mrr = DailyMrr.where(app_id: app_id, date: today.strftime('%d-%m-%Y')).pluck('sum(trial)').sum.to_f
    yesterday_mrr = DailyMrr.where(app_id: app_id, date: yesterday.strftime('%d-%m-%Y')).pluck('sum(trial)').sum.to_f

    if today_mrr.nil? || today_mrr.zero?
      number_with_precision(yesterday_mrr, precision: 2, delimiter: ',', separator: '.')
    else
      number_with_precision(today_mrr, precision: 2, delimiter: ',', separator: '.')
    end
  end

  def today_user_data(app_id)
    today = Date.today
    yesterday = (today - 1)

    today_count = DailyCount.where(app_id: app_id, date: today.strftime('%d-%m-%Y')).pluck('sum(user_count)').sum.to_f
    yesterday_count = DailyCount.where(app_id: app_id,
                                       date: yesterday.strftime('%d-%m-%Y')).pluck('sum(user_count)').sum.to_f

    if today_count.nil? || today_count.zero?
      number_with_precision(yesterday_count, precision: 0, delimiter: ',', separator: '.')
    else
      number_with_precision(today_count, precision: 0, delimiter: ',', separator: '.')
    end
  end

  def arpu(app_id)
    today = Date.today
    yesterday = (today - 1)

    today_net_revenue = Metric.where(app_id: app_id,
                                     date: today.strftime('%d-%m-%Y')).pluck('sum(net_revenue)').sum.to_f
    yesterday_net_revenue = Metric.where(app_id: app_id,
                                         date: yesterday.strftime('%d-%m-%Y')).pluck('sum(net_revenue)').sum.to_f

    today_count = DailyCount.where(app_id: app_id, date: today.strftime('%d-%m-%Y')).pluck('sum(user_count)').sum.to_f
    yesterday_count = DailyCount.where(app_id: app_id,
                                       date: yesterday.strftime('%d-%m-%Y')).pluck('sum(user_count)').sum.to_f

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

  def gross_on_date(date, app_id)
    gross = DailyMrr.where(app_id: app_id, date: date).pluck('sum(amount)').sum.to_f
    number_with_precision(gross, precision: 2, delimiter: ',', separator: '.')
  end

  def latest_gross_mrr(app_id)
    today = Date.today
    yesterday = (today - 1)

    today_mrr = Metric.where(app_id: app_id, date: today.strftime('%d-%m-%Y')).pluck('sum(mrr)').sum.to_f
    yesterday_mrr = Metric.where(app_id: app_id, date: yesterday.strftime('%d-%m-%Y')).pluck('sum(mrr)').sum.to_f

    if today_mrr.nil? || today_mrr.zero?
      number_with_precision(yesterday_mrr, precision: 2, delimiter: ',', separator: '.')
    else
      number_with_precision(today_mrr, precision: 2, delimiter: ',', separator: '.')
    end
  end

  def latest_net_revenue(app_id)
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

  def latest_arr(app_id)
    today = Date.today
    yesterday = (today - 1)

    today_net_revenue = Metric.where(app_id: app_id,
                                     date: today.strftime('%d-%m-%Y')).pluck('sum(net_revenue)').sum.to_f
    yesterday_net_revenue = Metric.where(app_id: app_id,
                                         date: yesterday.strftime('%d-%m-%Y')).pluck('sum(net_revenue)').sum.to_f

    if today_net_revenue.nil? || today_net_revenue.zero?
      number_with_precision(yesterday_net_revenue * 12, precision: 2, delimiter: ',', separator: '.')
    else
      number_with_precision(today_net_revenue * 12, precision: 2, delimiter: ',', separator: '.')
    end
  end

  def recurring_revenue(app_id)
    end_date = Date.today
    start_date = (end_date - 30.days)

    recurring_revenue = Metric.where(app_id: app_id,
                                     date: start_date..end_date).pluck('sum(recurring_revenue)').sum.to_f

    number_with_precision(recurring_revenue, precision: 2, delimiter: ',', separator: '.')
  end

  def one_time_charge(app_id)
    end_date = Date.today
    start_date = (end_date - 30.days)

    one_time_charge = Metric.where(app_id: app_id, date: start_date..end_date).pluck('sum(one_time_charge)').sum.to_f

    number_with_precision(one_time_charge, precision: 2, delimiter: ',', separator: '.')
  end

  def refunds(app_id)
    end_date = Date.today
    start_date = (end_date - 30.days)

    refunds = Metric.where(app_id: app_id, date: start_date..end_date).pluck('sum(refunds)').sum.to_f

    number_with_precision(refunds, precision: 2, delimiter: ',', separator: '.')
  end

  def app_requests(app_id)
    Review.where(app_id: app_id).where.not(requested_on: nil).count.to_i
  end

  def app_reviews(app_id)
    Review.where(app_id: app_id).where.not(received_on: nil).count.to_i
  end

  def app_calls(app_id)
    Call.where(app_id: app_id).count.to_i
  end

  def app_chats(app_id)
    Chat.where(app_id: app_id).count.to_i
  end

  def shopify_apps
    [
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
  end
end
