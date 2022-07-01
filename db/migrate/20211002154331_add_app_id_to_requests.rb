# frozen_string_literal: true

class AddAppIdToRequests < ActiveRecord::Migration[6.1]
  def change
    add_column :requests, :app_id, :integer
  end
end
