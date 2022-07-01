# frozen_string_literal: true

class TaskChecklistsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_task_checklist, only: %i[show edit update destroy]

  # GET /task_checklists or /task_checklists.json
  def index
    @task_checklists = TaskChecklist.all
  end

  # GET /task_checklists/1 or /task_checklists/1.json
  def show; end

  # GET /task_checklists/new
  def new
    @task_checklist = TaskChecklist.new
  end

  # GET /task_checklists/1/edit
  def edit; end

  # POST /task_checklists or /task_checklists.json
  def create
    @task_checklist = TaskChecklist.new(task_checklist_params)

    respond_to do |format|
      if @task_checklist.save
        format.html { redirect_to @task_checklist, notice: 'Task checklist was successfully created.' }
        format.json { render :show, status: :created, location: @task_checklist }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @task_checklist.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /task_checklists/1 or /task_checklists/1.json
  def update
    respond_to do |format|
      if @task_checklist.update(task_checklist_params)
        format.html { redirect_to @task_checklist, notice: 'Task checklist was successfully updated.' }
        format.json { render :show, status: :ok, location: @task_checklist }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @task_checklist.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /task_checklists/1 or /task_checklists/1.json
  def destroy
    @task_checklist.destroy
    respond_to do |format|
      format.html { redirect_to task_checklists_url, notice: 'Task checklist was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_task_checklist
    @task_checklist = TaskChecklist.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def task_checklist_params
    params.require(:task_checklist).permit(:task_id, :item, :status, :added_by)
  end
end
