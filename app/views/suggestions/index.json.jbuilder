# frozen_string_literal: true

json.array! @suggestions, partial: 'suggestions/suggestion', as: :suggestion
