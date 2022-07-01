# frozen_string_literal: true

class AddPlanToDailyCounts < ActiveRecord::Migration[6.1]
  def change
    add_column :daily_counts, :app, :text
  end
end
