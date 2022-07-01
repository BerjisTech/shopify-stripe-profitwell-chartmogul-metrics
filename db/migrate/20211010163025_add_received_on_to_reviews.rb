# frozen_string_literal: true

class AddReceivedOnToReviews < ActiveRecord::Migration[6.1]
  def change
    add_column :reviews, :received_on, :datetime
  end
end
