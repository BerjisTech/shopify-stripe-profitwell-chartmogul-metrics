# frozen_string_literal: true

class CreateStripeData < ActiveRecord::Migration[6.1]
  def change
    create_table :stripe_data, id: :uuid, &:timestamps
  end
end
