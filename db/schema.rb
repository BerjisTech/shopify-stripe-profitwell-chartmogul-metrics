# frozen_string_literal: true

# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20_220_315_184_149) do
  # These are extensions that must be enabled in order to support this database
  enable_extension 'pgcrypto'
  enable_extension 'plpgsql'

  create_table 'accounts', id: :uuid, default: -> { 'public.gen_random_uuid()' }, force: :cascade do |t|
    t.uuid 'user_id'
    t.uuid 'role_id'
    t.datetime 'created_at', precision: 6, null: false
    t.datetime 'updated_at', precision: 6, null: false
    t.string 'first_name'
    t.string 'last_name'
    t.uuid 'direct_report'
  end

  create_table 'action_text_rich_texts', id: :uuid, default: -> { 'public.gen_random_uuid()' }, force: :cascade do |t|
    t.string 'name', null: false
    t.text 'body'
    t.string 'record_type', null: false
    t.uuid 'record_id', null: false
    t.datetime 'created_at', precision: 6, null: false
    t.datetime 'updated_at', precision: 6, null: false
    t.index %w[record_type record_id name], name: 'index_action_text_rich_texts_uniqueness', unique: true
  end

  create_table 'active_admin_comments', force: :cascade do |t|
    t.string 'namespace'
    t.text 'body'
    t.string 'resource_type'
    t.bigint 'resource_id'
    t.string 'author_type'
    t.bigint 'author_id'
    t.datetime 'created_at', precision: 6, null: false
    t.datetime 'updated_at', precision: 6, null: false
    t.index %w[author_type author_id], name: 'index_active_admin_comments_on_author'
    t.index ['namespace'], name: 'index_active_admin_comments_on_namespace'
    t.index %w[resource_type resource_id], name: 'index_active_admin_comments_on_resource'
  end

  create_table 'active_storage_attachments', id: :uuid, default: lambda {
                                                                   'public.gen_random_uuid()'
                                                                 }, force: :cascade do |t|
    t.string 'name', null: false
    t.string 'record_type', null: false
    t.uuid 'record_id', null: false
    t.uuid 'blob_id', null: false
    t.datetime 'created_at', null: false
    t.index ['blob_id'], name: 'index_active_storage_attachments_on_blob_id'
    t.index %w[record_type record_id name blob_id], name: 'index_active_storage_attachments_uniqueness',
                                                    unique: true
  end

  create_table 'active_storage_blobs', id: :uuid, default: -> { 'public.gen_random_uuid()' }, force: :cascade do |t|
    t.string 'key', null: false
    t.string 'filename', null: false
    t.string 'content_type'
    t.text 'metadata'
    t.bigint 'byte_size', null: false
    t.string 'checksum', null: false
    t.datetime 'created_at', null: false
    t.string 'service_name', null: false
    t.index ['key'], name: 'index_active_storage_blobs_on_key', unique: true
  end

  create_table 'active_storage_variant_records', id: :uuid, default: lambda {
                                                                       'public.gen_random_uuid()'
                                                                     }, force: :cascade do |t|
    t.uuid 'blob_id', null: false
    t.string 'variation_digest', null: false
    t.index %w[blob_id variation_digest], name: 'index_active_storage_variant_records_uniqueness', unique: true
  end

  create_table 'admin_users', id: :uuid, default: -> { 'public.gen_random_uuid()' }, force: :cascade do |t|
    t.string 'email', default: '', null: false
    t.string 'encrypted_password', default: '', null: false
    t.string 'reset_password_token'
    t.datetime 'reset_password_sent_at'
    t.datetime 'remember_created_at'
    t.datetime 'created_at', precision: 6, null: false
    t.datetime 'updated_at', precision: 6, null: false
    t.index ['email'], name: 'index_admin_users_on_email', unique: true
    t.index ['reset_password_token'], name: 'index_admin_users_on_reset_password_token', unique: true
  end

  create_table 'affiliates', id: :uuid, default: -> { 'public.gen_random_uuid()' }, force: :cascade do |t|
    t.uuid 'app_id'
    t.string 'platform'
    t.datetime 'created_at', precision: 6, null: false
    t.datetime 'updated_at', precision: 6, null: false
  end

  create_table 'apis', id: :uuid, default: -> { 'public.gen_random_uuid()' }, force: :cascade do |t|
    t.uuid 'app_id'
    t.string 'name'
    t.text 'key'
    t.text 'secret'
    t.text 'password'
    t.text 'secondary'
    t.datetime 'created_at', precision: 6, null: false
    t.datetime 'updated_at', precision: 6, null: false
    t.text 'endpoint'
    t.string 'partner_id'
    t.text 'app_code'
  end

  create_table 'app_groups', id: :uuid, default: -> { 'public.gen_random_uuid()' }, force: :cascade do |t|
    t.string 'group_name'
    t.text 'group_description'
    t.datetime 'created_at', precision: 6, null: false
    t.datetime 'updated_at', precision: 6, null: false
    t.uuid 'user_id'
  end

  create_table 'apps', id: :uuid, default: -> { 'public.gen_random_uuid()' }, force: :cascade do |t|
    t.string 'app_name'
    t.integer 'app_code'
    t.integer 'partner_id'
    t.text 'api_key'
    t.text 'secondary_api_key'
    t.datetime 'created_at', precision: 6, null: false
    t.datetime 'updated_at', precision: 6, null: false
    t.uuid 'app_group_id'
    t.text 'data_point'
    t.string 'tag'
    t.uuid 'platform_id'
  end

  create_table 'big_rocks', id: :uuid, default: -> { 'public.gen_random_uuid()' }, force: :cascade do |t|
    t.uuid 'owner'
    t.uuid 'category'
    t.integer 'quater'
    t.text 'rock'
    t.integer 'status'
    t.datetime 'created_at', precision: 6, null: false
    t.datetime 'updated_at', precision: 6, null: false
    t.integer 'year'
  end

  create_table 'blockers', id: :uuid, default: -> { 'public.gen_random_uuid()' }, force: :cascade do |t|
    t.text 'item'
    t.uuid 'added_by'
    t.datetime 'created_at', precision: 6, null: false
    t.datetime 'updated_at', precision: 6, null: false
    t.uuid 'task_id'
  end

  create_table 'businesses', id: :uuid, default: -> { 'public.gen_random_uuid()' }, force: :cascade do |t|
    t.string 'name'
    t.datetime 'created_at', precision: 6, null: false
    t.datetime 'updated_at', precision: 6, null: false
  end

  create_table 'calls', id: :uuid, default: -> { 'public.gen_random_uuid()' }, force: :cascade do |t|
    t.uuid 'app_id'
    t.uuid 'user_id'
    t.text 'ticket'
    t.text 'comment'
    t.datetime 'date'
    t.datetime 'created_at', precision: 6, null: false
    t.datetime 'updated_at', precision: 6, null: false
  end

  create_table 'chats', id: :uuid, default: -> { 'public.gen_random_uuid()' }, force: :cascade do |t|
    t.uuid 'user_id'
    t.text 'chat_link'
    t.datetime 'date'
    t.text 'comment'
    t.datetime 'created_at', precision: 6, null: false
    t.datetime 'updated_at', precision: 6, null: false
    t.text 'ticket'
    t.uuid 'app_id'
  end

  create_table 'contests', id: :uuid, default: -> { 'public.gen_random_uuid()' }, force: :cascade do |t|
    t.datetime 'created_at', precision: 6, null: false
    t.datetime 'updated_at', precision: 6, null: false
    t.float 'request_price'
    t.float 'received_price'
    t.float 'chat_price'
    t.float 'call_price'
    t.uuid 'app_id'
    t.uuid 'platform_id'
    t.datetime 'period_start'
    t.datetime 'period_end'
  end

  create_table 'daily_counts', id: :uuid, default: -> { 'public.gen_random_uuid()' }, force: :cascade do |t|
    t.uuid 'app_id'
    t.integer 'user_count'
    t.datetime 'date'
    t.uuid 'plan_id'
    t.datetime 'created_at', precision: 6, null: false
    t.datetime 'updated_at', precision: 6, null: false
    t.text 'app'
    t.float 'paying'
    t.float 'trial'
  end

  create_table 'daily_mrrs', id: :uuid, default: -> { 'public.gen_random_uuid()' }, force: :cascade do |t|
    t.uuid 'app_id'
    t.integer 'level'
    t.float 'amount'
    t.datetime 'created_at', precision: 6, null: false
    t.datetime 'updated_at', precision: 6, null: false
    t.float 'trial'
    t.float 'arr'
    t.datetime 'date'
    t.integer 'unixdate'
  end

  create_table 'dashboards', id: :uuid, default: -> { 'public.gen_random_uuid()' }, force: :cascade do |t|
    t.datetime 'created_at', precision: 6, null: false
    t.datetime 'updated_at', precision: 6, null: false
  end

  create_table 'errors', id: :uuid, default: -> { 'public.gen_random_uuid()' }, force: :cascade do |t|
    t.json 'error'
    t.text 'origin'
    t.string 'controller'
    t.string 'method'
    t.datetime 'created_at', precision: 6, null: false
    t.datetime 'updated_at', precision: 6, null: false
  end

  create_table 'events', id: :uuid, default: -> { 'public.gen_random_uuid()' }, force: :cascade do |t|
    t.uuid 'app_id'
    t.text 'website'
    t.text 'email'
    t.text 'event'
    t.datetime 'time'
    t.datetime 'created_at', precision: 6, null: false
    t.datetime 'updated_at', precision: 6, null: false
  end

  create_table 'group_members', id: :uuid, default: -> { 'public.gen_random_uuid()' }, force: :cascade do |t|
    t.uuid 'group_id'
    t.uuid 'user_id'
    t.integer 'status'
    t.datetime 'created_at', precision: 6, null: false
    t.datetime 'updated_at', precision: 6, null: false
  end

  create_table 'kpis', id: :uuid, default: -> { 'gen_random_uuid()' }, force: :cascade do |t|
    t.datetime 'created_at', precision: 6, null: false
    t.datetime 'updated_at', precision: 6, null: false
  end

  create_table 'metrics', id: :uuid, default: -> { 'public.gen_random_uuid()' }, force: :cascade do |t|
    t.float 'mrr'
    t.float 'net_revenue'
    t.float 'fees'
    t.float 'other_revenue'
    t.float 'avg_revenue_per_user'
    t.float 'arr'
    t.float 'ltv'
    t.float 'mrr_growth_rate'
    t.float 'user_churn'
    t.float 'revenue_churn'
    t.float 'quick_ratio'
    t.integer 'active_customers'
    t.integer 'new_customers'
    t.integer 'reactivations'
    t.integer 'new_subscriptions'
    t.integer 'active_subscriptions'
    t.integer 'upgrades'
    t.integer 'downgrades'
    t.integer 'churned_customers'
    t.float 'coupons_redeemed'
    t.integer 'failed_charges'
    t.float 'refunds'
    t.datetime 'created_at', precision: 6, null: false
    t.datetime 'updated_at', precision: 6, null: false
    t.uuid 'app_id'
    t.datetime 'date'
    t.text 'last_cursor'
    t.json 'time_span'
    t.float 'one_time_charge'
    t.float 'recurring_revenue'
    t.integer 'closed_subscription'
    t.integer 'deactivations'
  end

  create_table 'notes', id: :uuid, default: -> { 'public.gen_random_uuid()' }, force: :cascade do |t|
    t.text 'note'
    t.uuid 'user_id'
    t.datetime 'created_at', precision: 6, null: false
    t.datetime 'updated_at', precision: 6, null: false
  end

  create_table 'owners', id: :uuid, default: -> { 'public.gen_random_uuid()' }, force: :cascade do |t|
    t.uuid 'app_id'
    t.uuid 'user_id'
    t.integer 'level'
    t.integer 'status'
    t.datetime 'created_at', precision: 6, null: false
    t.datetime 'updated_at', precision: 6, null: false
  end

  create_table 'plans', id: :uuid, default: -> { 'public.gen_random_uuid()' }, force: :cascade do |t|
    t.uuid 'app_id'
    t.text 'name'
    t.float 'price'
    t.datetime 'created_at', precision: 6, null: false
    t.datetime 'updated_at', precision: 6, null: false
  end

  create_table 'platforms', id: :uuid, default: -> { 'public.gen_random_uuid()' }, force: :cascade do |t|
    t.string 'name'
    t.datetime 'created_at', precision: 6, null: false
    t.datetime 'updated_at', precision: 6, null: false
  end

  create_table 'requests', id: :uuid, default: -> { 'public.gen_random_uuid()' }, force: :cascade do |t|
    t.uuid 'requested_by'
    t.uuid 'requested_from'
    t.text 'request'
    t.integer 'provided'
    t.datetime 'created_at', precision: 6, null: false
    t.datetime 'updated_at', precision: 6, null: false
    t.uuid 'app_id'
  end

  create_table 'resources', id: :uuid, default: -> { 'public.gen_random_uuid()' }, force: :cascade do |t|
    t.text 'resource'
    t.uuid 'task_id'
    t.datetime 'created_at', precision: 6, null: false
    t.datetime 'updated_at', precision: 6, null: false
  end

  create_table 'reviews', id: :uuid, default: -> { 'public.gen_random_uuid()' }, force: :cascade do |t|
    t.uuid 'app_id'
    t.float 'rating'
    t.uuid 'user_id'
    t.text 'ticket'
    t.text 'comment'
    t.datetime 'created_at', precision: 6, null: false
    t.datetime 'updated_at', precision: 6, null: false
    t.datetime 'requested_on'
    t.datetime 'received_on'
    t.text 'type'
    t.integer 'level'
  end

  create_table 'role_lists', id: :uuid, default: -> { 'public.gen_random_uuid()' }, force: :cascade do |t|
    t.string 'name'
    t.uuid 'role_id'
    t.datetime 'created_at', precision: 6, null: false
    t.datetime 'updated_at', precision: 6, null: false
  end

  create_table 'roles', id: :uuid, default: -> { 'public.gen_random_uuid()' }, force: :cascade do |t|
    t.uuid 'user_id'
    t.string 'name'
    t.datetime 'created_at', precision: 6, null: false
    t.datetime 'updated_at', precision: 6, null: false
  end

  create_table 'shopifies', id: :uuid, default: -> { 'public.gen_random_uuid()' }, force: :cascade do |t|
    t.datetime 'created_at', precision: 6, null: false
    t.datetime 'updated_at', precision: 6, null: false
  end

  create_table 'shopify_payments', id: :uuid, default: -> { 'public.gen_random_uuid()' }, force: :cascade do |t|
    t.datetime 'date'
    t.datetime 'billing_period_start'
    t.datetime 'billing_period_end'
    t.text 'payment_duration'
    t.text 'shop_name'
    t.text 'shop_domain'
    t.text 'shop_email'
    t.string 'shop_country'
    t.text 'details'
    t.text 'charge_type'
    t.float 'partner_sale'
    t.float 'shopify_fee'
    t.float 'processing_fee'
    t.float 'partner_share'
    t.text 'charge_id'
    t.datetime 'created_at', precision: 6, null: false
    t.datetime 'updated_at', precision: 6, null: false
    t.uuid 'app_id'
  end

  create_table 'shopify_users', id: :uuid, default: -> { 'public.gen_random_uuid()' }, force: :cascade do |t|
    t.text 'shop_name'
    t.text 'shop_domain'
    t.text 'shop_email'
    t.string 'shop_country'
    t.string 'shop_plan'
    t.datetime 'install_date'
    t.datetime 'created_at', precision: 6, null: false
    t.datetime 'updated_at', precision: 6, null: false
    t.uuid 'app_id'
  end

  create_table 'slack_apis', id: :uuid, default: -> { 'public.gen_random_uuid()' }, force: :cascade do |t|
    t.text 'current_bot_token'
    t.text 'current_user_token'
    t.text 'current_user_rotation'
    t.text 'current_bot_rotation'
    t.datetime 'created_at', precision: 6, null: false
    t.datetime 'updated_at', precision: 6, null: false
    t.text 'client_id'
    t.text 'client_secret'
    t.text 'signing_secret'
    t.text 'verification_token'
  end

  create_table 'slacks', id: :uuid, default: -> { 'public.gen_random_uuid()' }, force: :cascade do |t|
    t.string 'event'
    t.datetime 'created_at', precision: 6, null: false
    t.datetime 'updated_at', precision: 6, null: false
  end

  create_table 'stripe_data', id: :uuid, default: -> { 'public.gen_random_uuid()' }, force: :cascade do |t|
    t.datetime 'created_at', precision: 6, null: false
    t.datetime 'updated_at', precision: 6, null: false
  end

  create_table 'sub_tasks', id: :uuid, default: -> { 'public.gen_random_uuid()' }, force: :cascade do |t|
    t.text 'task'
    t.uuid 'assigned_to'
    t.uuid 'assigned_by'
    t.datetime 'deadline'
    t.datetime 'created_at', precision: 6, null: false
    t.datetime 'updated_at', precision: 6, null: false
    t.uuid 'task_id'
  end

  create_table 'suggestions', id: :uuid, default: -> { 'public.gen_random_uuid()' }, force: :cascade do |t|
    t.uuid 'user_id'
    t.uuid 'app_id'
    t.text 'suggestion'
    t.datetime 'created_at', precision: 6, null: false
    t.datetime 'updated_at', precision: 6, null: false
  end

  create_table 't2gs', id: :uuid, default: -> { 'public.gen_random_uuid()' }, force: :cascade do |t|
    t.datetime 'created_at', precision: 6, null: false
    t.datetime 'updated_at', precision: 6, null: false
  end

  create_table 'task_categories', id: :uuid, default: -> { 'public.gen_random_uuid()' }, force: :cascade do |t|
    t.text 'category'
    t.datetime 'created_at', precision: 6, null: false
    t.datetime 'updated_at', precision: 6, null: false
  end

  create_table 'task_checklists', id: :uuid, default: -> { 'public.gen_random_uuid()' }, force: :cascade do |t|
    t.uuid 'task_id'
    t.text 'item'
    t.integer 'status'
    t.uuid 'added_by'
    t.datetime 'created_at', precision: 6, null: false
    t.datetime 'updated_at', precision: 6, null: false
  end

  create_table 'task_comment_replies', id: :uuid, default: -> { 'public.gen_random_uuid()' }, force: :cascade do |t|
    t.text 'reply'
    t.uuid 'task_comment_id'
    t.uuid 'user_id'
    t.uuid 'task_id'
    t.datetime 'created_at', precision: 6, null: false
    t.datetime 'updated_at', precision: 6, null: false
  end

  create_table 'task_comments', id: :uuid, default: -> { 'public.gen_random_uuid()' }, force: :cascade do |t|
    t.text 'comment'
    t.uuid 'task_id'
    t.uuid 'user_id'
    t.datetime 'created_at', precision: 6, null: false
    t.datetime 'updated_at', precision: 6, null: false
  end

  create_table 'task_followers', id: :uuid, default: -> { 'public.gen_random_uuid()' }, force: :cascade do |t|
    t.uuid 'task_id'
    t.uuid 'user_id'
    t.datetime 'created_at', precision: 6, null: false
    t.datetime 'updated_at', precision: 6, null: false
  end

  create_table 'task_logs', id: :uuid, default: -> { 'public.gen_random_uuid()' }, force: :cascade do |t|
    t.uuid 'task'
    t.text 'log'
    t.uuid 'operator'
    t.datetime 'created_at', precision: 6, null: false
    t.datetime 'updated_at', precision: 6, null: false
  end

  create_table 'task_stages', id: :uuid, default: -> { 'public.gen_random_uuid()' }, force: :cascade do |t|
    t.string 'stage'
    t.datetime 'created_at', precision: 6, null: false
    t.datetime 'updated_at', precision: 6, null: false
  end

  create_table 'task_types', id: :uuid, default: -> { 'public.gen_random_uuid()' }, force: :cascade do |t|
    t.text 'name'
    t.datetime 'created_at', precision: 6, null: false
    t.datetime 'updated_at', precision: 6, null: false
  end

  create_table 'tasks', id: :uuid, default: -> { 'public.gen_random_uuid()' }, force: :cascade do |t|
    t.uuid 'assigned_by'
    t.uuid 'assigned_to'
    t.string 'task'
    t.text 'description'
    t.datetime 'deadline'
    t.datetime 'created_at', precision: 6, null: false
    t.datetime 'updated_at', precision: 6, null: false
    t.integer 'done'
    t.uuid 'app_id'
    t.integer 'is_blocker'
    t.uuid 'category'
    t.text 'resources'
    t.uuid 'task_type'
    t.uuid 'stage'
    t.integer 'is_priority'
    t.integer 'state'
  end

  create_table 'todos', id: :uuid, default: -> { 'public.gen_random_uuid()' }, force: :cascade do |t|
    t.uuid 'user_id'
    t.text 'to_do'
    t.datetime 'deadline'
    t.datetime 'created_at', precision: 6, null: false
    t.datetime 'updated_at', precision: 6, null: false
    t.integer 'done'
  end

  create_table 'transactions', id: :uuid, default: -> { 'public.gen_random_uuid()' }, force: :cascade do |t|
    t.float 'amount'
    t.text 'reason'
    t.integer 'type'
    t.uuid 'app_id'
    t.datetime 'created_at', precision: 6, null: false
    t.datetime 'updated_at', precision: 6, null: false
  end

  create_table 'users', id: :uuid, default: -> { 'public.gen_random_uuid()' }, force: :cascade do |t|
    t.bigint 'integer_id'
    t.string 'email', default: '', null: false
    t.string 'encrypted_password', default: '', null: false
    t.string 'reset_password_token'
    t.datetime 'reset_password_sent_at'
    t.datetime 'remember_created_at'
    t.datetime 'created_at', precision: 6, null: false
    t.datetime 'updated_at', precision: 6, null: false
    t.index ['email'], name: 'index_users_on_email', unique: true
    t.index ['reset_password_token'], name: 'index_users_on_reset_password_token', unique: true
  end

  create_table 'webhooks', id: :uuid, default: -> { 'public.gen_random_uuid()' }, force: :cascade do |t|
    t.text 'origin'
    t.uuid 'app_id'
    t.string 'platform'
    t.string 'slag'
    t.datetime 'created_at', precision: 6, null: false
    t.datetime 'updated_at', precision: 6, null: false
  end

  add_foreign_key 'active_storage_attachments', 'active_storage_blobs', column: 'blob_id'
  add_foreign_key 'active_storage_variant_records', 'active_storage_blobs', column: 'blob_id'
end
