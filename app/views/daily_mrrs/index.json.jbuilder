# frozen_string_literal: true

json.array! @daily_mrrs, partial: 'daily_mrrs/daily_mrr', as: :daily_mrr
