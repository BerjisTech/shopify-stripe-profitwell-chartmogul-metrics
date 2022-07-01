# frozen_string_literal: true

class AddTagToApps < ActiveRecord::Migration[6.1]
  def change
    add_column :apps, :tag, :string
  end
end
