# frozen_string_literal: true

json.array! @metrics, partial: 'metrics/metric', as: :metric
