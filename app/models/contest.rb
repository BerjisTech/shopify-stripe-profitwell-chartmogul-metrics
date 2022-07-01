# frozen_string_literal: true

# Contest Model
# rubocop:disable Metrics/MethodLength
class Contest < ApplicationRecord
  def self.review_ask(user_id, start_date, end_date)
    Review.where(user_id: user_id, level: 1, requested_on: start_date..end_date).count
  end

  def self.review_received(user_id, start_date, end_date)
    Review.where(user_id: user_id, level: 2, received_on: start_date..end_date).count
  end

  def self.live_chats(user_id, start_date, end_date)
    Chat.where(user_id: user_id, date: start_date..end_date).count
  end

  def self.live_calls(user_id, start_date, end_date)
    Call.where(user_id: user_id, date: start_date..end_date).count
  end

  def self.bonus(user_id, start_date, end_date)
    (review_ask(user_id, start_date, end_date) * 5) +
      (review_received(user_id, start_date, end_date) * 5) +
      (live_chats(user_id, start_date, end_date) * 5) +
      (live_calls(user_id, start_date, end_date) * 5)
  end

  def self.check_new_prices(contest)
    if Contest.find_by(app_id: contest[:app_id], period_end: contest[:period_end],
                       period_start: contest[:period_start]).present?
      { type: 'Error', message: "There's a contest for #{App.find(contest[:app_id]).app_name} in  this period" }
    else
      add_new_prices(contest)
    end
  end

  def self.add_new_prices(contest)
    Contest.create(
      app_id: contest[:app_id],
      call_price: contest[:call_price],
      chat_price: contest[:chat_price],
      period_end: contest[:period_end],
      period_start: contest[:period_start],
      platform_id: contest[:platform_id],
      received_price: contest[:received_price],
      request_price: contest[:request_price]
    )
    { type: 'Info', message: 'Contest succesfully created' }
  end
end

# rubocop:enable Metrics/MethodLength
