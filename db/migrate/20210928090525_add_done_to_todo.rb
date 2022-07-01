# frozen_string_literal: true

class AddDoneToTodo < ActiveRecord::Migration[6.1]
  def change
    add_column :todos, :done, :integer
  end
end
