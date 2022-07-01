# frozen_string_literal: true

class TaskCommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_task_comment, only: %i[show edit update destroy]

  # GET /task_comments or /task_comments.json
  def index
    @task_comments = TaskComment.all
  end

  # GET /task_comments/1 or /task_comments/1.json
  def show; end

  # GET /task_comments/new
  def new
    @task_comment = TaskComment.new
  end

  # GET /task_comments/1/edit
  def edit; end

  # POST /task_comments or /task_comments.json
  def create
    @task_comment = TaskComment.new(task_comment_params)

    respond_to do |format|
      if @task_comment.save
        format.html { redirect_to @task_comment, notice: 'Task comment was successfully created.' }
        format.json { render :show, status: :created, location: @task_comment }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @task_comment.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /task_comments/1 or /task_comments/1.json
  def update
    respond_to do |format|
      if @task_comment.update(task_comment_params)
        format.html { redirect_to @task_comment, notice: 'Task comment was successfully updated.' }
        format.json { render :show, status: :ok, location: @task_comment }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @task_comment.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /task_comments/1 or /task_comments/1.json
  def destroy
    @task_comment.destroy
    respond_to do |format|
      format.html { redirect_to task_comments_url, notice: 'Task comment was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_task_comment
    @task_comment = TaskComment.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def task_comment_params
    params.require(:task_comment).permit(:comment, :task_id, :user_id)
  end
end
