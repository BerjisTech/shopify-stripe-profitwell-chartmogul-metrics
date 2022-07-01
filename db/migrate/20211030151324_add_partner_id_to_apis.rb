# frozen_string_literal: true

class AddPartnerIdToApis < ActiveRecord::Migration[6.1]
  def change
    add_column :apis, :partner_id, :string
  end
end
