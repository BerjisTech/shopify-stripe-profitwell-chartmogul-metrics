# frozen_string_literal: true

class AddPeriodToContest < ActiveRecord::Migration[6.1]
  def change
    add_column :contests, :period_start, :datetime
    add_column :contests, :period_end, :datetime
  end
end
