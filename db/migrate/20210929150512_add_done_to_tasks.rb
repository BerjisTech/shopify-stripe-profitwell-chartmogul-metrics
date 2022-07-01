# frozen_string_literal: true

class AddDoneToTasks < ActiveRecord::Migration[6.1]
  def change
    add_column :tasks, :done, :integer
  end
end
