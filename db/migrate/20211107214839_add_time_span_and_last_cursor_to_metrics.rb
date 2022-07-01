# frozen_string_literal: true

class AddTimeSpanAndLastCursorToMetrics < ActiveRecord::Migration[6.1]
  def change
    add_column :metrics, :last_cursor, :text
    add_column :metrics, :time_span, :json
  end
end
