# frozen_string_literal: true

class AddPayingToDailyCounts < ActiveRecord::Migration[6.1]
  def change
    add_column :daily_counts, :paying, :float
  end
end
