# frozen_string_literal: true

class Kpi < ApplicationRecord
  class << self
    def per_date(_date)
      DailyMrr.where(date: Date.today).joins(app: :app_group).order(group_name: :ASC).order('app.created_at ASC').pluck(
        :app_name, :group_name, :trial, :amount, 'daily_mrrs.date'
      )
    end
  end
end
