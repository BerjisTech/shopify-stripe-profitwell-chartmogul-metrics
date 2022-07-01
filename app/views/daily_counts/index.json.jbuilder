# frozen_string_literal: true

json.array! @daily_counts, partial: 'daily_counts/daily_count', as: :daily_count
