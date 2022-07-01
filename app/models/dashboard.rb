# frozen_string_literal: true

# Dashboard Model
# rubocop:disable Metrics/MethodLength
class Dashboard < ApplicationRecord
  def self.dates
    today = Date.today
    last_month = (today - 30)
    dates = {
      today: today.strftime('%B %e, %Y'),
      last_month: last_month.strftime('%B %e, %Y')
    }
    OpenStruct.new dates
  end

  def self.my_apps_numbers(my_apps)
    mrr = 0
    trial = 0
    users = 0

    my_apps.map do |app|
      mrr += App.latest_app_mrr(app.app_id)
      trial += App.latest_app_trial_mrr(app.app_id)
      users += App.latest_app_users(app.app_id)
    end

    {
      mrr: number_with_precision(mrr, precision: 2, delimiter: ',', separator: '.'),
      trial: number_with_precision(trial, precision: 2, delimiter: ',', separator: '.'),
      users: users
    }
  end

  def self.my_apps_data(my_apps)
    ids = []
    my_apps.map do |app|
      ids << { id: app.app_id }
    end
  end

  def self.my_apps_mrr(my_apps)
    my_apps_mrr = []
    my_apps.map do |app|
      my_apps_mrr << {
        name: App.find(app.app_id).app_name,
        amount: App.latest_app_mrr(app.app_id)
      }
    end
    my_apps_mrr
  end
end

# rubocop:enable Metrics/MethodLength
