# frozen_string_literal: true

# Account controller
# rubocop:disable Metrics/AbcSize
# rubocop:disable Metrics/MethodLength
# rubocop:disable Metrics/ClassLength
class AccountsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_account, only: %i[show edit update destroy]
  before_action :redirect_if_not_admin, only: %i[index]
  before_action :account?, only: %i[new]
  before_action :set_todo, only: %i[show load_my_todos]
  before_action :set_task, only: %i[show load_my_tasks]
  before_action :set_request, only: %i[show load_my_requests]
  before_action :my_account?, only: %i[show]

  # GET /accounts or /accounts.json
  def index
    @accounts = Account.all.order(role_id: :asc)
  rescue NoMethodError => e
    Rollbar.error(e, @accounts.errors)
  end

  # GET /accounts/1 or /accounts/1.json
  def show; end

  def load_my_todos
    render inline: '<%= render "accounts/todos/my_todos" %>'
  end

  def load_my_tasks
    render inline: '<%= render "accounts/tasks/my_tasks" %>'
  end

  def load_my_requests
    render inline: '<%= render "accounts/requests/my_requests" %>'
  end

  # GET /accounts/new
  def new
    @account = Account.new
  end

  # GET /accounts/1/edit
  def edit; end

  # POST /accounts or /accounts.json
  def create
    @account = Account.new(account_params)

    @account.role_id = 10 if @account.role_id.nil? || @account.role_id.blank?

    respond_to do |format|
      if @account.save
        format.html { redirect_to @account, notice: 'Account was successfully created.' }
        format.json { render :show, status: :created, location: @account }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @account.errors, status: :unprocessable_entity }
      end
    end
  end

  def rep_metrics_update
    if params[:category] == 'request'
      Review.find_or_create_by(user_id: params[:user_id], app_id: params[:app_id], ticket: params[:ticket],
                               requested_on: params[:date], level: 1)
    end
    if params[:category] == 'received'
      Review.find_or_create_by(user_id: params[:user_id], app_id: params[:app_id], ticket: params[:ticket],
                               received_on: params[:date], level: 2)
    end
    if params[:category] == 'chat'
      Chat.find_or_create_by(user_id: params[:user_id], app_id: params[:app_id], ticket: params[:ticket],
                             date: params[:date])
    end
    if params[:category] == 'call'
      Call.find_or_create_by(user_id: params[:user_id], app_id: params[:app_id], ticket: params[:ticket],
                             date: params[:date])
    end
  end

  def load_rep_metrics_table
    @account = Account.find(params[:account_id])
    render inline: '<%= render "accounts/reps/metrics_table" %>'
  end

  # PATCH/PUT /accounts/1 or /accounts/1.json
  def update
    respond_to do |format|
      if @account.update(account_params)
        format.html { redirect_to @account, notice: 'Account was successfully updated.' }
        format.json { render :show, status: :ok, location: @account }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @account.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /accounts/1 or /accounts/1.json
  def destroy
    @account.destroy
    respond_to do |format|
      format.html { redirect_to accounts_url, notice: 'Account was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  def redirect_if_not_admin
    return unless Account.role(current_user.id) != 'admin' && Account.role(current_user.id) != 'hr & records'
  end

  def account?
    if Account.where(user_id: current_user.id).count.positive? # rubocop:disable Style/GuardClause
      redirect_to account_path(Account.find_by(user_id: current_user.id).id)
    end
  end

  def my_account?
    return unless Account.role(current_user.id) != 'admin' && current_user.id != params[:id]
  end

  def set_todo
    @todos = Todo.where(user_id: params[:account], done: 0).order(deadline: :asc)
  end

  def set_task
    @tasks = Task.where(assigned_to: params[:account], done: 0).order(is_priority: :asc).order(deadline: :asc)
  end

  def set_request
    @requests = Request.where(requested_from: params[:account], provided: 0).order(created_at: :asc)
  end

  # Use callbacks to share common setup or constraints between actions.
  def set_account
    @account = Account.find(params[:id])
    @my_apps = Owner.where(user_id: @account.user_id)
  rescue NoMethodError => e
    Rollbar.info(e, @account.errors)
  end

  # Only allow a list of trusted parameters through.
  def account_params
    params.require(:account).permit(:user_id, :role_id, :first_name, :last_name)
  end
end

# rubocop:enable Metrics/ClassLength
# rubocop:enable Metrics/MethodLength
# rubocop:enable Metrics/AbcSize
