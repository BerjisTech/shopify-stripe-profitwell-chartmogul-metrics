# frozen_string_literal: true

class CreateDashboards < ActiveRecord::Migration[6.1]
  def change
    create_table :dashboards, &:timestamps
  end
end
