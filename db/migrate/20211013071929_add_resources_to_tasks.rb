# frozen_string_literal: true

class AddResourcesToTasks < ActiveRecord::Migration[6.1]
  def change
    add_column :tasks, :resources, :text
  end
end
