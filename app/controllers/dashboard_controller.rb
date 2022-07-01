# frozen_string_literal: true

# Dashboard
# rubocop:disable Metrics/AbcSize
class DashboardController < ApplicationController
  before_action :authenticate_user!
  before_action :set_account
  before_action :account_session

  def index
    @today_mrr = DailyMrr.today_mrr_data
    @today_trial = DailyMrr.today_trial_data
    @today_user = DailyCount.today_user_data

    @general_mrr_data = DailyMrr.general_mrr_data
    @my_apps = my_apps
    @my_apps_mrr = Dashboard.my_apps_mrr(@my_apps)
    @my_apps_numbers = OpenStruct.new Dashboard.my_apps_numbers(@my_apps)
  end

  def assign_mrr_variables(app_mrr)
    { arr: app_mrr.arr || 0,
      amount: app_mrr.amount || 0,
      trial: app_mrr.trial || 0 }
  end

  def tiles
    apps = App.all
    @mrrs = []

    apps.order(created_at: :asc).map do |app|
      app_mrr = DailyMrr.where(app_id: app.id).last
      mrr_vars = OpenStruct.new assign_mrr_variables(app_mrr)
      mrr_data = format_mrr(app, mrr_vars)
      @mrrs.push(mrr_data)
    end
  end

  def format_mrr(app, mrr_vars)
    {
      app_id: app.id,
      app_code: app.app_code,
      app_name: app.app_name,
      paid_arr: mrr_vars.arr,
      paid_mrr: mrr_vars.amount,
      trial_mrr: mrr_vars.trial
    }
  end

  def set_account
    @account = if params[:user_id].present?
                 Account.find_by(user_id: params[:user_id])
               else
                 Account.find_or_create_by(user_id: current_user.id)
               end

    if @account.first_name.blank?
      redirect_to edit_account_path(@account.id),
                  notice: 'Setup your account to be able to fully use the system'
    end

    if @account.role_id.blank?
      Account.where(id: @account.id).update_all(role_id: Role.find_by(name: 'Customer Hero').id)
    end

    @my_open_tasks = Task.where(assigned_to: @account.user_id, done: 0).where('created_at >?',
                                                                              2.days.ago).pluck('count(id)').first
    @my_overdue_tasks = Task.where(assigned_to: @account.user_id, done: 0).where('deadline <?',
                                                                                 Date.today).pluck('count(id)').first
    @my_closed_tasks = Task.where(assigned_to: @account.user_id, done: 1).pluck('count(id)').first

    @my_todos = Todo.where(user_id: @account.user_id, done: 0).order(deadline: :asc).limit(10)

    @my_requests = Request.where(provided: 0).where('requested_by =? OR requested_from =?', @account.user_id,
                                                    @account.user_id).order(created_at: :asc)
  end

  def my_apps
    Owner.where(user_id: @account.user_id)
  end
end

# rubocop:enable Metrics/AbcSize
