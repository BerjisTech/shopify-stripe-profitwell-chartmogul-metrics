# frozen_string_literal: true

class AddArrToDailyMrrs < ActiveRecord::Migration[6.1]
  def change
    add_column :daily_mrrs, :arr, :float
  end
end
