# frozen_string_literal: true

# Model
class DailyCount < ApplicationRecord
  belongs_to :plan

  def self.today_user_data
    today = Date.today
    yesterday = (today - 1)

    today_count = DailyCount.where(date: today.strftime('%d-%m-%Y')).pluck('sum(user_count)').sum.to_f
    yesterday_count = DailyCount.where(date: yesterday.strftime('%d-%m-%Y')).pluck('sum(user_count)').sum.to_f

    if today_count.nil? || today_count.zero?
      number_with_precision(yesterday_count, precision: 0, delimiter: ',', separator: '.')
    else
      number_with_precision(today_count, precision: 0, delimiter: ',', separator: '.')
    end
  end
end
