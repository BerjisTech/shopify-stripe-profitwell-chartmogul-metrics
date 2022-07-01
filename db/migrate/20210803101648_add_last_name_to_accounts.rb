# frozen_string_literal: true

class AddLastNameToAccounts < ActiveRecord::Migration[6.1]
  def change
    add_column :accounts, :last_name, :string
  end
end
