# frozen_string_literal: true

class AddTrialToDailyMrrs < ActiveRecord::Migration[6.1]
  def change
    add_column :daily_mrrs, :trial, :float
  end
end
