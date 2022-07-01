# frozen_string_literal: true

module DashboardHelper
  def user_reviews(user_id)
    reviews = {}
    reviews = if Account.editor(user_id)
                {
                  asks: Review.where(level: 1).where.not(requested_on: nil).count.to_i,
                  received: Review.where(level: 2).where.not(received_on: nil).count.to_i
                }
              else
                {
                  asks: Review.where(level: 1, user_id: user_id).where.not(requested_on: nil).count.to_i,
                  received: Review.where(level: 2, user_id: user_id).where.not(received_on: nil).count.to_i
                }
              end
    OpenStruct.new reviews
  end

  def user_chats(user_id)
    if Account.editor(user_id)
      Chat.where.not(date: nil).count.to_i
    else
      Chat.where(user_id: user_id).where.not(date: nil).count.to_i
    end
  end

  def user_calls(user_id)
    if Account.editor(user_id)
      Call.where.not(date: nil).count.to_i
    else
      Call.where(user_id: user_id).where.not(date: nil).count.to_i
    end
  end
end
