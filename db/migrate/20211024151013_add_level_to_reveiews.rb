# frozen_string_literal: true

class AddLevelToReveiews < ActiveRecord::Migration[6.1]
  def change
    add_column :reviews, :level, :integer
  end
end
