# frozen_string_literal: true

class AddRequestedOnToReviews < ActiveRecord::Migration[6.1]
  def change
    add_column :reviews, :requested_on, :datetime
  end
end
