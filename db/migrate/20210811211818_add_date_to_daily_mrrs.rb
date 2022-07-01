# frozen_string_literal: true

class AddDateToDailyMrrs < ActiveRecord::Migration[6.1]
  def change
    add_column :daily_mrrs, :date, :timestamp
  end
end
