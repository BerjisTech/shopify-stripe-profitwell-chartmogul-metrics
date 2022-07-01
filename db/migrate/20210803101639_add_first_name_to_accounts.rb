# frozen_string_literal: true

class AddFirstNameToAccounts < ActiveRecord::Migration[6.1]
  def change
    add_column :accounts, :first_name, :string
  end
end
