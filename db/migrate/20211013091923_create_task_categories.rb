# frozen_string_literal: true

class CreateTaskCategories < ActiveRecord::Migration[6.1]
  def change
    create_table :task_categories, id: :uuid do |t|
      t.text :category

      t.timestamps
    end
  end
end
