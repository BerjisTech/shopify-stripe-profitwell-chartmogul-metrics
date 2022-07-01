# frozen_string_literal: true

class CreateShopifies < ActiveRecord::Migration[6.1]
  def change
    create_table :shopifies, id: :uuid, &:timestamps
  end
end
