# frozen_string_literal: true

json.array! @affiliates, partial: 'affiliates/affiliate', as: :affiliate
