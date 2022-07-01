# frozen_string_literal: true

# Data Controller
class LtvDataController < ApplicationController
  def t2g
    render json: Profitwell.start_update
  end

  def sk
    render json: Sk.start_update
  end

  def ujinga
    ChartMogul.account_token = Api.key(12, 'Chartmogul').key || ''
    ChartMogul.secret_key = Api.key(12, 'Chartmogul').secret || ''
    render json: ChartMogul::Metrics.customer_count(start_date: Chartmogul.dates.start_date,
                                                    end_date: Chartmogul.dates.end_date,
                                                    interval: 'month', plans: params[:plan])
  end

  def qt
    render json: Qt.start_update
  end

  def fetch_icu
    # render json: DailyMrr.fetch_mrr

    path = 'https://incartupsell.herokuapp.com/api/v1/shops_mrr?key_token=df7c96c198cdk899hk'
    body = { shop: { date_min: '', date_max: '' } }
    data = post_call(path, body)

    # app_id = App.find_by(app_code: 767_045).id

    body = data.body
    body = JSON.parse body

    # user_count = []

    # DailyMrr.new(
    #   app_id: app_id,
    #   trial: body["trial_mrr"],
    #   amount: body["paying_mrr"],
    #   arr: body["paying_arr"],
    # ).save

    # body["plans"].map do |plan|
    #   user_count << {
    #     app_id: app_id,
    #     user_count: plan["number_of_users"],
    #     date: body["current_date"],
    #     plan_id: Plan.find_or_create_by(name: plan["name"], app_id: app_id, price: plan["price"]).id,
    #     app: plan["name"],
    #   }
    # end

    # DailyCount.create(user_count)

    render json: body
  end

  # COD APPS
  def fetch_prdrly
    path = 'https://preorderly.azurewebsites.net/preorder/GetMRR?ps=prdrly'
    data = Faraday.get path

    body = data.body
    render json: body
  end

  def fetch_satcb
    path = 'https://stickyaddtocartbar.azurewebsites.net/api/Home/GetMRR?ps=satcb'
    data = Faraday.get path

    body = data.body

    render json: body
  end

  def fetch_rocket
    path = 'https://window-shoppers.azurewebsites.net/Activity/GetMRR?ps=ws'
    data = Faraday.get path

    body = data.body
    render json: body
  end

  def fetch_upselly
    path = 'https://upselly.azurewebsites.net/home/GetMRR?ps=psly'
    data = Faraday.get path

    body = data.body
    render json: body
  end

  # WOD APPS

  def fetch_pon
    token = Digest::SHA1.hexdigest('LTV_SAAS_GROWTH_PON')

    path = "https://preorder-now.herokuapp.com/api/v1/mrr?token=#{token}"
    data = Faraday.get path

    body = data.body
    render json: body
  end

  def fetch_bdn
    token = Digest::SHA1.hexdigest('LTV_SAAS_GROWTH_BDN')

    path = "https://quantity-breaks-now.herokuapp.com/api/v1/mrr?token=#{token}"
    data = Faraday.get path

    body = data.body
    render json: body
  end

  def fetch_wpn
    token = Digest::SHA1.hexdigest('LTV_SAAS_GROWTH_WPN')

    path = "https://wholesale-pricing-now.herokuapp.com/api/v1/mrr?token=#{token}"

    data = Faraday.get path

    body = data.body
    render json: body
  end

  def post_call(path, body)
    headers = {
      'Accept': 'application/json',
      'Content-Type': 'application/json'
    }
    Faraday.post(path, body.to_json, headers)
  end
end
