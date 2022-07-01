# frozen_string_literal: true

class TaskComment < ApplicationRecord
  has_rich_text :comment
end
