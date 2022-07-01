# frozen_string_literal: true

class AddTypeToReviews < ActiveRecord::Migration[6.1]
  def change
    add_column :reviews, :type, :text
  end
end
