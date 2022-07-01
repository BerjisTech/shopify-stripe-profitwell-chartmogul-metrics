# frozen_string_literal: true

Rails.application.routes.draw do # rubocop:disable Metrics/BlockLength
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  resources :apis,
            :affiliates,
            :daily_mrrs,
            :daily_counts,
            :plans,
            :accounts,
            :calls,
            :reviews,
            :events,
            :group_members,
            :app_groups,
            :owners,
            :apps,
            :tasks,
            :todos,
            :requests,
            :suggestions,
            :webhooks,
            :errors,
            :big_rocks,
            :chats,
            :calls,
            :slacks
  # resources :notes

  devise_for :users, path: '', path_names: { sign_in: 'login', sign_out: 'logout', sign_up: 'register' }

  get 'referals/:app', controller: :affiliates, action: :referals
  get 'refersion/ouath', controller: :affiliates, action: :refersion_ouath
  get 'affiliates/payment/new', controller: :affiliates, action: :new_veem_payment

  get 'dashboard/index'
  get 'tiles', controller: :dashboard, action: :tiles
  get 'dashboard/user/:user_id', controller: :dashboard, action: :index

  get 'fund/:fund', controller: :app_groups, action: :show
  get 'funds', controller: :app_groups, action: :index

  # Home
  get 'home/index'
  get 'home/about'
  get 'home/pricing'
  get 'home/faq'
  get 'home/privacy_policy'
  get 'home/terms_and_conditions'
  get 'home/refund_policy'
  get 'home/api'
  get 'home/docs'
  get 'home/support'
  get 'home/help'

  # Admin
  get 'admin', controller: :admin, action: :index
  get 'roles', controller: :admin, action: :roles
  get 'role/add/:role', controller: :admin, action: :add_role
  post 'update_direct_report', controller: :admin, action: :update_direct_report

  get 'kpi/data'
  get 'data', controller: :kpi, action: :data

  get 'privacy-policy', controller: :home, action: :privacy_policy
  get 'dashboard', controller: :dashboard, action: :index

  get 'api/v1/event', controller: :events, action: :api

  # ICU
  get 'icu', controller: :ltv_data, action: :fetch_icu

  # WOD
  get 'pon', controller: :ltv_data, action: :fetch_pon
  get 'bdn', controller: :ltv_data, action: :fetch_bdn
  get 'wpn', controller: :ltv_data, action: :fetch_wpn

  # COD
  get 'preorderly', controller: :ltv_data, action: :fetch_prdrly
  get 'sticky', controller: :ltv_data, action: :fetch_satcb
  get 'rocket', controller: :ltv_data, action: :fetch_rocket
  get 'upselly', controller: :ltv_data, action: :fetch_upselly

  # T2G
  get 't2g', controller: :ltv_data, action: :t2g

  # SK
  get 'sk', controller: :ltv_data, action: :sk

  # QT
  get 'qt', controller: :ltv_data, action: :qt

  # Extra Mrr links
  get 'dlymrr/get', controller: :fucking_mrr, action: :get
  get 'dlymrr/post', controller: :fucking_mrr, action: :post
  get 'ujinga/:plan', controller: :ltv_data, action: :ujinga
  get 'dothefuckingupdatationismificatoionation', controller: :fucking_mrr, action: :stupidification
  get '/from/cron', controller: :metrics, action: :cron

  # todos extras
  post 'ajax_todo', controller: :todos, action: :create
  get 'todo/fetch/:account', controller: :accounts, action: :load_my_todos
  post 'todo/update', controller: :todos, action: :ajax_update

  # tasks extras
  post 'ajax_task', controller: :tasks, action: :create
  get 'task/fetch/:account', controller: :accounts, action: :load_my_tasks
  post 'task/update', controller: :tasks, action: :ajax_update
  get 'fetch_task_details', controller: :tasks, action: :details
  get 'fetch_tasks_per_stage', controller: :tasks, action: :fetch_per_stage
  post 'reprioritize_tasks', controller: :tasks, action: :reprioritze

  # requests extras
  post 'ajax_request', controller: :requests, action: :create
  get 'request/fetch/:account', controller: :accounts, action: :load_my_requests
  post 'request/update', controller: :requests, action: :ajax_update

  # Metrics
  post 'fetch_app_graph_data', controller: :apps, action: :bar_graph_data
  get 'kpi(/:fund(/:app_id))', controller: :metrics, action: :control_center
  get 'metrics(/:fund(/:app_id))', controller: :metrics, action: :metrics
  get 'forecast(/:fund(/:app_id))', controller: :metrics, action: :forecast
  get 'customers(/:fund(/:app_id))', controller: :metrics, action: :customers
  get 'benchmarks(/:fund(/:app_id))', controller: :metrics, action: :benchmarks
  get 'recover(/:fund(/:app_id))', controller: :metrics, action: :recover
  get 'cancellations(/:fund(/:app_id))', controller: :metrics, action: :cancellations
  get 'import/shopify_daily_data/:app/:data_set(/:time_start(/:time_end))', controller: :metrics,
                                                                            action: :shopify_daily_data
  get 'import/shopify_monthly_data/:app/:data_set(/:time_start(/:time_end))', controller: :metrics,
                                                                              action: :shopify_monthly_data
  get 'import/stripe/:app(/:time_start(/:time_end))', controller: :metrics, action: :stripe
  # get 'playground/:app', controller: :metrics, action: :playground
  get 'suppressed_emails/:app', controller: :metrics, action: :csv
  get 'shopify_emergency_data_fix/:app/:data_set(/:time_start/:time_end)', controller: :metrics,
                                                                           action: :shopify_emergency_data_fix
  get 'shopify_emergency_data_fix_urls/:data_set(/:time_start(/:time_end))', controller: :metrics,
                                                                             action: :shopify_emergency_data_fix_urls

  # Contests
  post 'rep_metrics_update/:category', controller: :accounts, action: :rep_metrics_update
  get 'load_rep_metrics_table/:account_id', controller: :accounts, action: :load_rep_metrics_table
  get 'contest', controller: :contest, action: :index
  post 'new_contest', controller: :contest, action: :new

  # get 'webhooks/reviews/:app_id/:type', controller: :reviews, action: :received
  post 'webhooks/reviews/:app_id/:type', controller: :reviews, action: :received

  # notes
  post 'user_note', controller: :notes, action: :ajax_update

  # graphql
  post 'graphql', controller: :graphql, action: :execute

  root controller: :dashboard, action: :index

  # Mockup
  get 'mockup/apps', controller: :mockup, action: :apps
  get 'mockup/app', controller: :mockup, action: :app
  get 'mockup/businesses', controller: :mockup, action: :businesses
  get 'mockup/business', controller: :mockup, action: :business
  get 'mockup/control_center', controller: :mockup, action: :control_center
  get 'mockup/metrics', controller: :mockup, action: :metrics

  # SLACK EVENTS
  get 'slack/install', controller: :slacks, action: :install, as: :slack_install
  get 'slack/mrr', controller: :slacks, action: :mrr, as: :slack_mrr
  get 'slack/contest', controller: :slacks, action: :contest, as: :slack_contest
  get 'slack/slash_event_test', controller: :slacks, action: :slash_event_test, as: :slash_event_test
  get 'slack', controller: :slacks, action: :slash_event_test

  post 'slack/events', controller: :slacks, action: :events, as: :slack_events
  post 'slack/mrr', controller: :slacks, action: :mrr
  post 'slack/contest', controller: :slacks, action: :contest
  post 'slack/slash_event_test', controller: :slacks, action: :slash_event_test
  post '/slack/interact', controller: :slack, action: :interact
  post 'slack', controller: :slacks, action: :slash_event_test

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
