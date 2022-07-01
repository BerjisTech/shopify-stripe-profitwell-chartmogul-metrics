# frozen_string_literal: true

class KpiController < ApplicationController
  before_action :authenticate_user!
  before_action :set_kpi

  def data
    apps = App.all
    @mrrs = getmrr(apps)
  end

  def getmrr(apps)
    @mrrs = []
    apps.order(id: :asc).map do |app|
      app_mrr = DailyMrr.where(app_id: app.id).last
      if app_mrr.nil?
        arr = 0
        amount = 0
        trial = 0
      else
        arr = app_mrr.arr
        amount = app_mrr.amount
        trial = app_mrr.trial
      end
      @mrrs << {
        app_id: app.id,
        app_code: app.app_code,
        app_name: app.app_name,
        paid_arr: arr,
        paid_mrr: amount,
        trial_mrr: trial
      }
    end
    @mrrs
  end

  def set_kpi
    @days = DailyMrr.days
  end
end
