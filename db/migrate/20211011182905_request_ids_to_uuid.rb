# frozen_string_literal: true

class RequestIdsToUuid < ActiveRecord::Migration[6.1]
  def change
    execute "ALTER TABLE requests ALTER COLUMN requested_by SET DATA TYPE UUID USING (uuid(lpad(replace(text(app_id),'-',''), 32, '0')));"
    execute "ALTER TABLE requests ALTER COLUMN requested_from SET DATA TYPE UUID USING (uuid(lpad(replace(text(app_id),'-',''), 32, '0')));"
  end

  def down
    raise ActiveRecord::IrreversibleMigration
  end
end
