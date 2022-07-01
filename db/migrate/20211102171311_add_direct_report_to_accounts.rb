# frozen_string_literal: true

class AddDirectReportToAccounts < ActiveRecord::Migration[6.1]
  def change
    add_column :accounts, :direct_report, :uuid
  end
end
