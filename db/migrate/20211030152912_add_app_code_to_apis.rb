# frozen_string_literal: true

class AddAppCodeToApis < ActiveRecord::Migration[6.1]
  def change
    add_column :apis, :app_code, :text
  end
end
