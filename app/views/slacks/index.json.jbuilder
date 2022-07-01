# frozen_string_literal: true

json.array! @slacks, partial: 'slacks/slack', as: :slack
