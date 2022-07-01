# frozen_string_literal: true

# Tasks
# rubocop:disable Metrics/MethodLength
# rubocop:disable Metrics/AbcSize
# rubocop:disable Metrics/CyclomaticComplexity
class TasksController < ApplicationController
  before_action :authenticate_user!
  before_action :set_task, only: %i[show edit update destroy]
  before_action :set_account

  # GET /tasks or /tasks.json
  def index
    @tasks = if Account.editor(current_user.id)
               Task.all.order(is_priority: :asc).order(deadline: :asc)
             else
               Task.where(assigned_to: current_user.id).order(is_priority: :asc).order(deadline: :asc)
             end
  end

  # GET /tasks/1 or /tasks/1.json
  def show; end

  # GET /tasks/new
  def new
    @task = Task.new
  end

  def fetch_per_stage
    @tasks = Task.where(stage: params[:stage]).order(is_priority: :asc).order(deadline: :asc)
    render inline: '<%= render \'tasks/task/index\' %> '
  end

  def reprioritze
    params[:tasks].each_with_index.each do |task, index|
      Task.find(task).update(is_priority: index + 1)
    end
    render json: Task.where(id: params[:tasks]).order(is_priority: :asc).order(deadline: :asc)
  end

  def details
    @task = Task.find(params[:task])
    render inline: '<%= render \'tasks/task/details\' %> '
  end

  # GET /tasks/1/edit
  def edit; end

  # POST /tasks or /tasks.json
  def create
    @task = Task.new(task_params)
    @task.assigned_by = current_user.id
    # @task.deadline = DateTime.now if @task.deadline.nil?
    @task.done = 0
    @task.state = 0
    @task.is_priority = Task.all.count + 1 if @task.is_priority.zero?
    @task.stage = TaskStage.find_by(stage: 'Open').id

    if @task.save
      'task was successfully created.'
    else
      @task.errors
    end
  end

  # PATCH/PUT /tasks/1 or /tasks/1.json
  def update
    respond_to do |format|
      if @task.update(task_params)
        format.html { redirect_to @task, notice: 'Task was successfully updated.' }
        format.json { render :show, status: :ok, location: @task }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
  end

  def ajax_update
    task_action = params[:task_action]
    task = params[:id]

    response = case task_action
               when 'start'
                 Task.start(task, current_user.id)
               when 'pause'
                 Task.pause(task, current_user.id)
               when 'resume'
                 Task.resume(task, current_user.id)
               when 'submit'
                 Task.submit(task, current_user.id)
               when 'test'
                 Task.test(task, current_user.id)
               when 'review'
                 Task.review(task, current_user.id)
               when 'document'
                 Task.document(task, current_user.id)
               when 'close'
                 Task.close(task, current_user.id)
               when 'reject'
                 Task.reject(task, current_user.id)
               end

    render json: response
  end

  # DELETE /tasks/1 or /tasks/1.json
  def destroy
    @task.destroy
    respond_to do |format|
      format.html { redirect_to tasks_url, notice: 'Task was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_task
    @task = Task.find(params[:id])
  end

  def set_account
    @account = Account.find_by(user_id: current_user.id)
  end

  # Only allow a list of trusted parameters through.
  def task_params
    params.require(:task).permit(:assigned_by, :assigned_to, :task, :description, :deadline, :app_id, :is_blocker,
                                 :stage, :category, :task_type, :resources, :is_priority)
  end
end

# rubocop:enable Metrics/CyclomaticComplexity
# rubocop:enable Metrics/MethodLength
# rubocop:enable Metrics/AbcSize
