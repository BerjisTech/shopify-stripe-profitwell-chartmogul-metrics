# frozen_string_literal: true

class AddRecurringRevenueToMetrics < ActiveRecord::Migration[6.1]
  def change
    add_column :metrics, :recurring_revenue, :float
  end
end
