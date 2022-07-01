# frozen_string_literal: true

class AddDataPointToApps < ActiveRecord::Migration[6.1]
  def change
    add_column :apps, :data_point, :text
  end
end
