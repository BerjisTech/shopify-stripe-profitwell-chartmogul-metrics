# frozen_string_literal: true

json.array! @blockers, partial: 'blockers/blocker', as: :blocker
