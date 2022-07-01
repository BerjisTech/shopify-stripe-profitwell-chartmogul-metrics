# frozen_string_literal: true

class AddEndpointToApis < ActiveRecord::Migration[6.1]
  def change
    add_column :apis, :endpoint, :text
  end
end
