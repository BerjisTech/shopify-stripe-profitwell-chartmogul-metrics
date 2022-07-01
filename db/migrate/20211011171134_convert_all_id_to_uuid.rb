# frozen_string_literal: true

# IDS to UUIDS
# rubocop:disable Layout/LineLength
# rubocop:disable Metrics/MethodLength
# rubocop:disable Metrics/AbcSize
class ConvertAllIdToUuid < ActiveRecord::Migration[6.1]
  def up
    # ACCOUNTS TABLES
    execute 'ALTER TABLE accounts ALTER COLUMN id DROP DEFAULT;'
    execute "ALTER TABLE accounts ALTER COLUMN user_id SET DATA TYPE UUID USING (uuid(lpad(replace(text(user_id),'-',''), 32, '0')));"
    execute "ALTER TABLE accounts ALTER COLUMN role_id SET DATA TYPE UUID USING (uuid(lpad(replace(text(role_id),'-',''), 32, '0')));"
    execute "ALTER TABLE accounts ALTER COLUMN id SET DATA TYPE UUID USING (uuid(lpad(replace(text(id),'-',''), 32, '0')));"
    execute 'ALTER TABLE accounts ALTER COLUMN id SET DEFAULT gen_random_uuid();'

    # AFFILIATES TABLES
    execute 'ALTER TABLE affiliates ALTER COLUMN id DROP DEFAULT;'
    execute "ALTER TABLE affiliates ALTER COLUMN app_id SET DATA TYPE UUID USING (uuid(lpad(replace(text(app_id),'-',''), 32, '0')));"
    execute "ALTER TABLE affiliates ALTER COLUMN id SET DATA TYPE UUID USING (uuid(lpad(replace(text(id),'-',''), 32, '0')));"
    execute 'ALTER TABLE affiliates ALTER COLUMN id SET DEFAULT gen_random_uuid();'

    # APP GROUPS TABLES
    execute 'ALTER TABLE app_groups ALTER COLUMN id DROP DEFAULT;'
    execute "ALTER TABLE app_groups ALTER COLUMN user_id SET DATA TYPE UUID USING (uuid(lpad(replace(text(user_id),'-',''), 32, '0')));"
    execute "ALTER TABLE app_groups ALTER COLUMN id SET DATA TYPE UUID USING (uuid(lpad(replace(text(id),'-',''), 32, '0')));"
    execute 'ALTER TABLE app_groups ALTER COLUMN id SET DEFAULT gen_random_uuid();'

    # APPS TABLES
    execute 'ALTER TABLE apps ALTER COLUMN id DROP DEFAULT;'
    execute "ALTER TABLE apps ALTER COLUMN app_group_id SET DATA TYPE UUID USING (uuid(lpad(replace(text(app_group_id),'-',''), 32, '0')));"
    execute "ALTER TABLE apps ALTER COLUMN id SET DATA TYPE UUID USING (uuid(lpad(replace(text(id),'-',''), 32, '0')));"
    execute 'ALTER TABLE apps ALTER COLUMN id SET DEFAULT gen_random_uuid();'

    # CALLS TABLES
    execute 'ALTER TABLE calls ALTER COLUMN id DROP DEFAULT;'
    execute "ALTER TABLE calls ALTER COLUMN app_id SET DATA TYPE UUID USING (uuid(lpad(replace(text(app_id),'-',''), 32, '0')));"
    execute "ALTER TABLE calls ALTER COLUMN user_id SET DATA TYPE UUID USING (uuid(lpad(replace(text(user_id),'-',''), 32, '0')));"
    execute "ALTER TABLE calls ALTER COLUMN id SET DATA TYPE UUID USING (uuid(lpad(replace(text(id),'-',''), 32, '0')));"
    execute 'ALTER TABLE calls ALTER COLUMN id SET DEFAULT gen_random_uuid();'

    # CHARTMOGULS TABLES
    # execute 'ALTER TABLE chartmoguls ALTER COLUMN id DROP DEFAULT;'
    # execute "ALTER TABLE chartmoguls ALTER COLUMN id SET DATA TYPE UUID USING (uuid(lpad(replace(text(id),'-',''), 32, '0')));"
    # execute 'ALTER TABLE chartmoguls ALTER COLUMN id SET DEFAULT gen_random_uuid();'

    # DAILY COUNTS TABLES
    execute 'ALTER TABLE daily_counts ALTER COLUMN id DROP DEFAULT;'
    execute "ALTER TABLE daily_counts ALTER COLUMN app_id SET DATA TYPE UUID USING (uuid(lpad(replace(text(app_id),'-',''), 32, '0')));"
    execute "ALTER TABLE daily_counts ALTER COLUMN plan_id SET DATA TYPE UUID USING (uuid(lpad(replace(text(plan_id),'-',''), 32, '0')));"
    execute "ALTER TABLE daily_counts ALTER COLUMN id SET DATA TYPE UUID USING (uuid(lpad(replace(text(id),'-',''), 32, '0')));"
    execute 'ALTER TABLE daily_counts ALTER COLUMN id SET DEFAULT gen_random_uuid();'

    # DAILY MRRS TABLES
    execute 'ALTER TABLE daily_mrrs ALTER COLUMN id DROP DEFAULT;'
    execute "ALTER TABLE daily_mrrs ALTER COLUMN app_id SET DATA TYPE UUID USING (uuid(lpad(replace(text(app_id),'-',''), 32, '0')));"
    execute "ALTER TABLE daily_mrrs ALTER COLUMN id SET DATA TYPE UUID USING (uuid(lpad(replace(text(id),'-',''), 32, '0')));"
    execute 'ALTER TABLE daily_mrrs ALTER COLUMN id SET DEFAULT gen_random_uuid();'

    # EVENTS TABLES
    execute 'ALTER TABLE events ALTER COLUMN id DROP DEFAULT;'
    execute "ALTER TABLE events ALTER COLUMN app_id SET DATA TYPE UUID USING (uuid(lpad(replace(text(app_id),'-',''), 32, '0')));"
    execute "ALTER TABLE events ALTER COLUMN id SET DATA TYPE UUID USING (uuid(lpad(replace(text(id),'-',''), 32, '0')));"
    execute 'ALTER TABLE events ALTER COLUMN id SET DEFAULT gen_random_uuid();'

    # GROUP MEMBERS TABLES
    execute 'ALTER TABLE group_members ALTER COLUMN id DROP DEFAULT;'
    execute "ALTER TABLE group_members ALTER COLUMN group_id SET DATA TYPE UUID USING (uuid(lpad(replace(text(group_id),'-',''), 32, '0')));"
    execute "ALTER TABLE group_members ALTER COLUMN user_id SET DATA TYPE UUID USING (uuid(lpad(replace(text(user_id),'-',''), 32, '0')));"
    execute "ALTER TABLE group_members ALTER COLUMN id SET DATA TYPE UUID USING (uuid(lpad(replace(text(id),'-',''), 32, '0')));"
    execute 'ALTER TABLE group_members ALTER COLUMN id SET DEFAULT gen_random_uuid();'

    # NOTES TABLES
    execute 'ALTER TABLE notes ALTER COLUMN id DROP DEFAULT;'
    execute "ALTER TABLE notes ALTER COLUMN user_id SET DATA TYPE UUID USING (uuid(lpad(replace(text(user_id),'-',''), 32, '0')));"
    execute "ALTER TABLE notes ALTER COLUMN id SET DATA TYPE UUID USING (uuid(lpad(replace(text(id),'-',''), 32, '0')));"
    execute 'ALTER TABLE notes ALTER COLUMN id SET DEFAULT gen_random_uuid();'

    # OWNERS TABLES
    execute 'ALTER TABLE owners ALTER COLUMN id DROP DEFAULT;'
    execute "ALTER TABLE owners ALTER COLUMN app_id SET DATA TYPE UUID USING (uuid(lpad(replace(text(app_id),'-',''), 32, '0')));"
    execute "ALTER TABLE owners ALTER COLUMN user_id SET DATA TYPE UUID USING (uuid(lpad(replace(text(user_id),'-',''), 32, '0')));"
    execute "ALTER TABLE owners ALTER COLUMN id SET DATA TYPE UUID USING (uuid(lpad(replace(text(id),'-',''), 32, '0')));"
    execute 'ALTER TABLE owners ALTER COLUMN id SET DEFAULT gen_random_uuid();'

    # PLANS TABLES
    execute 'ALTER TABLE plans ALTER COLUMN id DROP DEFAULT;'
    execute "ALTER TABLE plans ALTER COLUMN app_id SET DATA TYPE UUID USING (uuid(lpad(replace(text(app_id),'-',''), 32, '0')));"
    execute "ALTER TABLE plans ALTER COLUMN id SET DATA TYPE UUID USING (uuid(lpad(replace(text(id),'-',''), 32, '0')));"
    execute 'ALTER TABLE plans ALTER COLUMN id SET DEFAULT gen_random_uuid();'

    # QTS TABLES
    # execute 'ALTER TABLE qts ALTER COLUMN id DROP DEFAULT;'
    # execute "ALTER TABLE qts ALTER COLUMN id SET DATA TYPE UUID USING (uuid(lpad(replace(text(id),'-',''), 32, '0')));"
    # execute 'ALTER TABLE qts ALTER COLUMN id SET DEFAULT gen_random_uuid();'

    # REQUESTS TABLES
    execute 'ALTER TABLE requests ALTER COLUMN id DROP DEFAULT;'
    execute "ALTER TABLE requests ALTER COLUMN app_id SET DATA TYPE UUID USING (uuid(lpad(replace(text(app_id),'-',''), 32, '0')));"
    execute "ALTER TABLE requests ALTER COLUMN id SET DATA TYPE UUID USING (uuid(lpad(replace(text(id),'-',''), 32, '0')));"
    execute 'ALTER TABLE requests ALTER COLUMN id SET DEFAULT gen_random_uuid();'

    # REVIEWS TABLES
    execute 'ALTER TABLE reviews ALTER COLUMN id DROP DEFAULT;'
    execute "ALTER TABLE reviews ALTER COLUMN app_id SET DATA TYPE UUID USING (uuid(lpad(replace(text(app_id),'-',''), 32, '0')));"
    execute "ALTER TABLE reviews ALTER COLUMN user_id SET DATA TYPE UUID USING (uuid(lpad(replace(text(user_id),'-',''), 32, '0')));"
    execute "ALTER TABLE reviews ALTER COLUMN id SET DATA TYPE UUID USING (uuid(lpad(replace(text(id),'-',''), 32, '0')));"
    execute 'ALTER TABLE reviews ALTER COLUMN id SET DEFAULT gen_random_uuid();'

    # ROLES TABLES
    execute 'ALTER TABLE roles ALTER COLUMN id DROP DEFAULT;'
    execute "ALTER TABLE roles ALTER COLUMN user_id SET DATA TYPE UUID USING (uuid(lpad(replace(text(user_id),'-',''), 32, '0')));"
    execute "ALTER TABLE roles ALTER COLUMN id SET DATA TYPE UUID USING (uuid(lpad(replace(text(id),'-',''), 32, '0')));"
    execute 'ALTER TABLE roles ALTER COLUMN id SET DEFAULT gen_random_uuid();'

    # SKS TABLES
    # execute 'ALTER TABLE sks ALTER COLUMN id DROP DEFAULT;'
    # execute "ALTER TABLE sks ALTER COLUMN id SET DATA TYPE UUID USING (uuid(lpad(replace(text(id),'-',''), 32, '0')));"
    # execute 'ALTER TABLE sks ALTER COLUMN id SET DEFAULT gen_random_uuid();'

    # SUGGESTIONS TABLES
    execute 'ALTER TABLE suggestions ALTER COLUMN id DROP DEFAULT;'
    execute "ALTER TABLE suggestions ALTER COLUMN app_id SET DATA TYPE UUID USING (uuid(lpad(replace(text(app_id),'-',''), 32, '0')));"
    execute "ALTER TABLE suggestions ALTER COLUMN user_id SET DATA TYPE UUID USING (uuid(lpad(replace(text(user_id),'-',''), 32, '0')));"
    execute "ALTER TABLE suggestions ALTER COLUMN id SET DATA TYPE UUID USING (uuid(lpad(replace(text(id),'-',''), 32, '0')));"
    execute 'ALTER TABLE suggestions ALTER COLUMN id SET DEFAULT gen_random_uuid();'

    # T2GS TABLES
    execute 'ALTER TABLE t2gs ALTER COLUMN id DROP DEFAULT;'
    execute "ALTER TABLE t2gs ALTER COLUMN id SET DATA TYPE UUID USING (uuid(lpad(replace(text(id),'-',''), 32, '0')));"
    execute 'ALTER TABLE t2gs ALTER COLUMN id SET DEFAULT gen_random_uuid();'

    # TASKS TABLES
    execute 'ALTER TABLE tasks ALTER COLUMN id DROP DEFAULT;'
    execute "ALTER TABLE tasks ALTER COLUMN app_id SET DATA TYPE UUID USING (uuid(lpad(replace(text(app_id),'-',''), 32, '0')));"
    execute "ALTER TABLE tasks ALTER COLUMN assigned_by SET DATA TYPE UUID USING (uuid(lpad(replace(text(assigned_by),'-',''), 32, '0')));"
    execute "ALTER TABLE tasks ALTER COLUMN assigned_to SET DATA TYPE UUID USING (uuid(lpad(replace(text(assigned_to),'-',''), 32, '0')));"
    execute "ALTER TABLE tasks ALTER COLUMN id SET DATA TYPE UUID USING (uuid(lpad(replace(text(id),'-',''), 32, '0')));"
    execute 'ALTER TABLE tasks ALTER COLUMN id SET DEFAULT gen_random_uuid();'

    # TODOS TABLES
    execute 'ALTER TABLE todos ALTER COLUMN id DROP DEFAULT;'
    execute "ALTER TABLE todos ALTER COLUMN user_id SET DATA TYPE UUID USING (uuid(lpad(replace(text(user_id),'-',''), 32, '0')));"
    execute "ALTER TABLE todos ALTER COLUMN id SET DATA TYPE UUID USING (uuid(lpad(replace(text(id),'-',''), 32, '0')));"
    execute 'ALTER TABLE todos ALTER COLUMN id SET DEFAULT gen_random_uuid();'

    # TRANSACTIONS TABLES
    execute 'ALTER TABLE transactions ALTER COLUMN id DROP DEFAULT;'
    execute "ALTER TABLE transactions ALTER COLUMN app_id SET DATA TYPE UUID USING (uuid(lpad(replace(text(app_id),'-',''), 32, '0')));"
    execute "ALTER TABLE transactions ALTER COLUMN id SET DATA TYPE UUID USING (uuid(lpad(replace(text(id),'-',''), 32, '0')));"
    execute 'ALTER TABLE transactions ALTER COLUMN id SET DEFAULT gen_random_uuid();'

    # WEBHOOKS TABLES
    execute 'ALTER TABLE webhooks ALTER COLUMN id DROP DEFAULT;'
    execute "ALTER TABLE webhooks ALTER COLUMN app_id SET DATA TYPE UUID USING (uuid(lpad(replace(text(app_id),'-',''), 32, '0')));"
    execute "ALTER TABLE webhooks ALTER COLUMN id SET DATA TYPE UUID USING (uuid(lpad(replace(text(id),'-',''), 32, '0')));"
    execute 'ALTER TABLE webhooks ALTER COLUMN id SET DEFAULT gen_random_uuid();'
  end

  def down
    raise ActiveRecord::IrreversibleMigration
  end
end

# rubocop:enable Metrics/AbcSize
# rubocop:enable Metrics/MethodLength
# rubocop:enable Layout/LineLength
