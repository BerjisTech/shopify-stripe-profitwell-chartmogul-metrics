# frozen_string_literal: true

class AddStateToTasks < ActiveRecord::Migration[6.1]
  def change
    add_column :tasks, :state, :integer
  end
end
