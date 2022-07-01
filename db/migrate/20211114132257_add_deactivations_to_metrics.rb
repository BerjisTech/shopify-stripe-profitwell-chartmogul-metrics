# frozen_string_literal: true

class AddDeactivationsToMetrics < ActiveRecord::Migration[6.1]
  def change
    add_column :metrics, :deactivations, :integer
  end
end
