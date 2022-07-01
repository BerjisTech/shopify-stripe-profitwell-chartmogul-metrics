# frozen_string_literal: true

class AddOneTimeChargeToMetrics < ActiveRecord::Migration[6.1]
  def change
    add_column :metrics, :one_time_charge, :float
  end
end
