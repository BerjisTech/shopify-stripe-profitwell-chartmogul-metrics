# frozen_string_literal: true

class CreateContests < ActiveRecord::Migration[6.1]
  def change
    create_table :contests, id: :uuid, &:timestamps
  end
end
