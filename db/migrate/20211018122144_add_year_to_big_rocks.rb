# frozen_string_literal: true

class AddYearToBigRocks < ActiveRecord::Migration[6.1]
  def change
    add_column :big_rocks, :year, :integer
  end
end
