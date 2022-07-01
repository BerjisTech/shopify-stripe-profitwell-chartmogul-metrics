# frozen_string_literal: true

class AddStageToTasks < ActiveRecord::Migration[6.1]
  def change
    add_column :tasks, :stage, :uuid
  end
end
