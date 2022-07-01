# frozen_string_literal: true

class TaskStagesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_task_stage, only: %i[show edit update destroy]

  # GET /task_stages or /task_stages.json
  def index
    @task_stages = TaskStage.all
  end

  # GET /task_stages/1 or /task_stages/1.json
  def show; end

  # GET /task_stages/new
  def new
    @task_stage = TaskStage.new
  end

  # GET /task_stages/1/edit
  def edit; end

  # POST /task_stages or /task_stages.json
  def create
    @task_stage = TaskStage.new(task_stage_params)

    respond_to do |format|
      if @task_stage.save
        format.html { redirect_to @task_stage, notice: 'Task stage was successfully created.' }
        format.json { render :show, status: :created, location: @task_stage }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @task_stage.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /task_stages/1 or /task_stages/1.json
  def update
    respond_to do |format|
      if @task_stage.update(task_stage_params)
        format.html { redirect_to @task_stage, notice: 'Task stage was successfully updated.' }
        format.json { render :show, status: :ok, location: @task_stage }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @task_stage.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /task_stages/1 or /task_stages/1.json
  def destroy
    @task_stage.destroy
    respond_to do |format|
      format.html { redirect_to task_stages_url, notice: 'Task stage was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_task_stage
    @task_stage = TaskStage.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def task_stage_params
    params.require(:task_stage).permit(:stage)
  end
end
