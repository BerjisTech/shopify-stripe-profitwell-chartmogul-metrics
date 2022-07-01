# frozen_string_literal: true

class TaskFollowersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_task_follower, only: %i[show edit update destroy]

  # GET /task_followers or /task_followers.json
  def index
    @task_followers = TaskFollower.all
  end

  # GET /task_followers/1 or /task_followers/1.json
  def show; end

  # GET /task_followers/new
  def new
    @task_follower = TaskFollower.new
  end

  # GET /task_followers/1/edit
  def edit; end

  # POST /task_followers or /task_followers.json
  def create
    @task_follower = TaskFollower.new(task_follower_params)

    respond_to do |format|
      if @task_follower.save
        format.html { redirect_to @task_follower, notice: 'Task follower was successfully created.' }
        format.json { render :show, status: :created, location: @task_follower }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @task_follower.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /task_followers/1 or /task_followers/1.json
  def update
    respond_to do |format|
      if @task_follower.update(task_follower_params)
        format.html { redirect_to @task_follower, notice: 'Task follower was successfully updated.' }
        format.json { render :show, status: :ok, location: @task_follower }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @task_follower.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /task_followers/1 or /task_followers/1.json
  def destroy
    @task_follower.destroy
    respond_to do |format|
      format.html { redirect_to task_followers_url, notice: 'Task follower was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_task_follower
    @task_follower = TaskFollower.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def task_follower_params
    params.require(:task_follower).permit(:task_id, :user_id)
  end
end
