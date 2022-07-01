# frozen_string_literal: true

class AddAppIdAndDateToMetrics < ActiveRecord::Migration[6.1]
  def change
    add_column :metrics, :app_id, :uuid
    add_column :metrics, :date, :datetime
  end
end
