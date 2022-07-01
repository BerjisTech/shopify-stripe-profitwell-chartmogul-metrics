# frozen_string_literal: true

# Model
# rubocop:disable Metrics/MethodLength
# rubocop:disable Metrics/AbcSize
class DailyMrr < ApplicationRecord # rubocop:disable Metrics/ClassLength
  belongs_to :app
  # belongs_to :metric, touch: :date

  def self.fetch_mrr
    DailyMrr.start_get
    DailyMrr.start_post
    # Profitwell apps
    Profitwell.start_update
    # Chartmogul app
    Chartmogul.start_update
  end

  def self.start_get
    DailyMrr.list_get_mrrs.map do |path|
      path = OpenStruct.new path
      get_data = DailyMrr.get_from_path(path.path)
      DailyMrr.data_format(get_data, path.app_id)
    end
  end

  def self.start_post
    DailyMrr.list_post_mrrs.map do |path|
      path = OpenStruct.new path
      post_data = DailyMrr.post_from_path(path.path, path.body)
      data = post_data.body
      DailyMrr.data_format(data, path.app_id)
    end
  end

  def self.list_get_mrrs
    [
      {
        app_id: App.find_by(app_name: 'Product Customizer').id,
        path: 'https://app.productcustomizer.com/api/v1/mrr'
      },
      {
        app_id: App.find_by(app_name: 'TrackifyX').id,
        path: 'https://trackifyx.redretarget.com/api/mrrRecordsv1?api_token=K5bl1oI0K1ohneAgezz8Pn8C9FVpzrDTneqVdux8onHkSUi1ukaNWHPhjWKS'
      },
      {
        app_id: App.find_by(app_name: 'Preorder Now').id,
        path: 'https://preorder-now.herokuapp.com/api/v1/mrr?token=217a7efe0d3c49aea34aa9eba923059135bcf493'
      },
      {
        app_id: App.find_by(app_name: 'Bulk Discount Now').id,
        path: 'https://quantity-breaks-now.herokuapp.com/api/v1/mrr?token=63fefbce6ce1f89c445f776babdd1e455d639306'
      },
      {
        app_id: App.find_by(app_name: 'Wholesale Pricing Now').id,
        path: 'https://wholesale-pricing-now.herokuapp.com/api/v1/mrr?token=c9c92ae2aec821166b418894fd95ff2d511091fd'
      },
      {
        app_id: App.find_by(app_name: 'Sticky Add To Cart Booster').id,
        path: 'https://stickyaddtocartbar.azurewebsites.net/api/Home/GetMRR?ps=satcb'
      },
      {
        app_id: App.find_by(app_name: 'Sales Rocket').id,
        path: 'https://window-shoppers.azurewebsites.net/Activity/GetMRR?ps=ws'
      },
      {
        app_id: App.find_by(app_name: 'Preorderly').id,
        path: 'https://preorderly.azurewebsites.net/preorder/GetMRR?ps=prdrly'
      },
      {
        app_id: App.find_by(app_name: 'Upselly').id,
        path: 'https://upselly.azurewebsites.net/home/GetMRR?ps=psly'
      }
    ]
  end

  def self.list_post_mrrs
    [
      {
        app_id: App.find_by(app_name: 'In Cart Upsell').id,
        path: 'https://incartupsell.herokuapp.com/api/v1/shops_mrr?key_token=df7c96c198cdk899hk',
        body: { shop: { date_min: '', date_max: '' } }
      }
    ]
  end

  def self.get_from_path(path)
    data = Faraday.get path

    data.body
  end

  def self.post_from_path(path, body)
    headers = {
      'Accept': 'application/json',
      'Content-Type': 'application/json'
    }
    Faraday.post(path, body.to_json, headers)
  end

  def self.data_format(data, app_id)
    body = JSON.parse data
    plans = body['plans']
    save_mrr(body, app_id)
    save_count(plans, app_id, body)
  end

  def self.save_mrr(body, app_id)
    destroy_duplicate_mrr(app_id, body['current_date'])
    DailyMrr.create!(
      app_id: app_id,
      trial: body['trial_mrr'],
      amount: body['paying_mrr'],
      arr: body['paying_arr'],
      date: body['current_date'],
      unixdate: body['current_time_stamp']
    )
  end

  def self.destroy_duplicate_mrr(app_id, date)
    duplicates = DailyMrr.where(app_id: app_id, date: date)

    duplicates.destroy_all if duplicates.present?
  end

  def self.save_count(plans, app_id, body) # rubocop:disable Metrics/MethodLength
    destroy_duplicate_count(app_id, body['current_date'])
    user_count = []
    plans.map do |plan|
      plan = OpenStruct.new plan
      user_count << {
        app_id: app_id,
        user_count: plan.number_of_users.to_i,
        paying: plan.mrr_paying,
        trial: plan.mrr_trial,
        date: body['current_date'],
        plan_id: Plan.find_or_create_by(name: plan.name, app_id: app_id, price: plan['price']).id,
        app: plan['name']
      }
    end
    DailyCount.create!(user_count)
  end

  def self.destroy_duplicate_count(app_id, date)
    duplicates = DailyCount.where(app_id: app_id, date: date)

    duplicates.destroy_all if duplicates.present?
  end

  def self.days
    DailyMrr.order(date: :desc).group(:date).select(:date).limit(7)
  end

  def self.subscribed_revenue(app_id, date)
    revenue = DailyMrr.where(app_id: app_id).where(date: date).select(:amount).first

    if revenue.present?
      revenue.amount
    else
      '--'
    end
  end

  def self.trial_revenue(app_id, date)
    revenue = DailyMrr.where(app_id: app_id).where(date: date).select(:trial).first

    if revenue.present?
      revenue.trial.to_f
    else
      0.0
    end
  end

  def self.general_mrr_data
    DailyMrr.group(:date).where(date: (Date.today - 30)..Date.today).order(date: :asc)
            .select('sum(amount) as amount, sum(trial) as trial, date')
  end

  def self.today_mrr_data
    today = Date.today
    yesterday = (today - 1)

    today_mrr = DailyMrr.where(date: today.strftime('%d-%m-%Y')).pluck('sum(amount)').sum.to_f
    yesterday_mrr = DailyMrr.where(date: yesterday.strftime('%d-%m-%Y')).pluck('sum(amount)').sum.to_f

    if today_mrr.nil? || today_mrr.zero?
      number_with_precision(yesterday_mrr, precision: 2, delimiter: ',', separator: '.')
    else
      number_with_precision(today_mrr, precision: 2, delimiter: ',', separator: '.')
    end
  end

  def self.today_trial_data
    today = Date.today
    yesterday = (today - 1)

    today_mrr = DailyMrr.where(date: today.strftime('%d-%m-%Y')).pluck('sum(trial)').sum.to_f
    yesterday_mrr = DailyMrr.where(date: yesterday.strftime('%d-%m-%Y')).pluck('sum(trial)').sum.to_f

    if today_mrr.nil? || today_mrr.zero?
      number_with_precision(yesterday_mrr, precision: 2, delimiter: ',', separator: '.')
    else
      number_with_precision(today_mrr, precision: 2, delimiter: ',', separator: '.')
    end
  end

  def self.mrr_on(date = Date.today, app_id)
    mrr = DailyMrr.find_by(app_id: app_id, date: date)
    if mrr.nil?
      { amount: 0, trial: 0 }
    else
      mrr
    end
  end
end

# rubocop:enable Metrics/AbcSize
# rubocop:enable Metrics/MethodLength
