# frozen_string_literal: true

class CreateT2gs < ActiveRecord::Migration[6.1]
  def change
    create_table :t2gs, &:timestamps
  end
end
