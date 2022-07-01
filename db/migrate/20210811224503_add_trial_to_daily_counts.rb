# frozen_string_literal: true

class AddTrialToDailyCounts < ActiveRecord::Migration[6.1]
  def change
    add_column :daily_counts, :trial, :float
  end
end
