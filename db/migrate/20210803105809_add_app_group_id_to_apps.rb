# frozen_string_literal: true

class AddAppGroupIdToApps < ActiveRecord::Migration[6.1]
  def change
    add_column :apps, :app_group_id, :integer
  end
end
