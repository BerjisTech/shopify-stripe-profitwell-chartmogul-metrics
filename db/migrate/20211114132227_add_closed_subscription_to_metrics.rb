# frozen_string_literal: true

class AddClosedSubscriptionToMetrics < ActiveRecord::Migration[6.1]
  def change
    add_column :metrics, :closed_subscription, :integer
  end
end
