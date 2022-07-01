# frozen_string_literal: true

class CreateKpis < ActiveRecord::Migration[6.1]
  def change
    create_table :kpis, id: :uuid, &:timestamps
  end
end
