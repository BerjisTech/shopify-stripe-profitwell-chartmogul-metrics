# frozen_string_literal: true

class AddCategoryToTasks < ActiveRecord::Migration[6.1]
  def change
    add_column :tasks, :category, :uuid
  end
end
