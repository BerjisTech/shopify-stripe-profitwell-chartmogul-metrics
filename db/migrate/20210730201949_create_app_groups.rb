# frozen_string_literal: true

class CreateAppGroups < ActiveRecord::Migration[6.1]
  def change
    create_table :app_groups do |t|
      t.string :group_name
      t.text :group_description

      t.timestamps
    end
  end
end
