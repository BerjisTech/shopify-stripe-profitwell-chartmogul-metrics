# frozen_string_literal: true

class AddUnixdateToDailyMrrs < ActiveRecord::Migration[6.1]
  def change
    add_column :daily_mrrs, :unixdate, :integer
  end
end
