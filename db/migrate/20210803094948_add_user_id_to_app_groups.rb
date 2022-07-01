# frozen_string_literal: true

class AddUserIdToAppGroups < ActiveRecord::Migration[6.1]
  def change
    add_column :app_groups, :user_id, :integer
  end
end
