# frozen_string_literal: true

class AddPlatformIdToApps < ActiveRecord::Migration[6.1]
  def change
    add_column :apps, :platform_id, :uuid
  end
end
