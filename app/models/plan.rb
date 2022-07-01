# frozen_string_literal: true

# Model
class Plan < ApplicationRecord
  belongs_to :app
  has_many :daily_counts
end
