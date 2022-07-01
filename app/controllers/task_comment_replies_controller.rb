# frozen_string_literal: true

class TaskCommentRepliesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_task_comment_reply, only: %i[show edit update destroy]

  # GET /task_comment_replies or /task_comment_replies.json
  def index
    @task_comment_replies = TaskCommentReply.all
  end

  # GET /task_comment_replies/1 or /task_comment_replies/1.json
  def show; end

  # GET /task_comment_replies/new
  def new
    @task_comment_reply = TaskCommentReply.new
  end

  # GET /task_comment_replies/1/edit
  def edit; end

  # POST /task_comment_replies or /task_comment_replies.json
  def create
    @task_comment_reply = TaskCommentReply.new(task_comment_reply_params)

    respond_to do |format|
      if @task_comment_reply.save
        format.html { redirect_to @task_comment_reply, notice: 'Task comment reply was successfully created.' }
        format.json { render :show, status: :created, location: @task_comment_reply }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @task_comment_reply.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /task_comment_replies/1 or /task_comment_replies/1.json
  def update
    respond_to do |format|
      if @task_comment_reply.update(task_comment_reply_params)
        format.html { redirect_to @task_comment_reply, notice: 'Task comment reply was successfully updated.' }
        format.json { render :show, status: :ok, location: @task_comment_reply }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @task_comment_reply.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /task_comment_replies/1 or /task_comment_replies/1.json
  def destroy
    @task_comment_reply.destroy
    respond_to do |format|
      format.html { redirect_to task_comment_replies_url, notice: 'Task comment reply was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_task_comment_reply
    @task_comment_reply = TaskCommentReply.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def task_comment_reply_params
    params.require(:task_comment_reply).permit(:reply, :task_comment_id, :user_id, :task_id)
  end
end
