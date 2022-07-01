# frozen_string_literal: true

class ConvertApisIntegerToUuid < ActiveRecord::Migration[6.1]
  def up
    # APIS TABLES
    execute 'ALTER TABLE apis ALTER COLUMN id DROP DEFAULT;'
    execute "ALTER TABLE apis ALTER COLUMN app_id SET DATA TYPE UUID USING (uuid(lpad(replace(text(app_id),'-',''), 32, '0')));"
    execute "ALTER TABLE apis ALTER COLUMN id SET DATA TYPE UUID USING (uuid(lpad(replace(text(id),'-',''), 32, '0')));"
    execute 'ALTER TABLE apis ALTER COLUMN id SET DEFAULT gen_random_uuid();'

    # DASHBOARD TABLES
    execute 'ALTER TABLE dashboards ALTER COLUMN id DROP DEFAULT;'
    execute "ALTER TABLE dashboards ALTER COLUMN id SET DATA TYPE UUID USING (uuid(lpad(replace(text(id),'-',''), 32, '0')));"
    execute 'ALTER TABLE dashboards ALTER COLUMN id SET DEFAULT gen_random_uuid();'

    # ERRORS TABLES
    execute 'ALTER TABLE errors ALTER COLUMN id DROP DEFAULT;'
    execute "ALTER TABLE errors ALTER COLUMN id SET DATA TYPE UUID USING (uuid(lpad(replace(text(id),'-',''), 32, '0')));"
    execute 'ALTER TABLE errors ALTER COLUMN id SET DEFAULT gen_random_uuid();'
  end

  def down
    raise ActiveRecord::IrreversibleMigration
  end
end
