# frozen_string_literal: true

class TaskCategoriesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_task_category, only: %i[show edit update destroy]

  # GET /task_categories or /task_categories.json
  def index
    @task_categories = TaskCategory.all
  end

  # GET /task_categories/1 or /task_categories/1.json
  def show; end

  # GET /task_categories/new
  def new
    @task_category = TaskCategory.new
  end

  # GET /task_categories/1/edit
  def edit; end

  # POST /task_categories or /task_categories.json
  def create
    @task_category = TaskCategory.new(task_category_params)

    respond_to do |format|
      if @task_category.save
        format.html { redirect_to @task_category, notice: 'Task category was successfully created.' }
        format.json { render :show, status: :created, location: @task_category }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @task_category.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /task_categories/1 or /task_categories/1.json
  def update
    respond_to do |format|
      if @task_category.update(task_category_params)
        format.html { redirect_to @task_category, notice: 'Task category was successfully updated.' }
        format.json { render :show, status: :ok, location: @task_category }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @task_category.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /task_categories/1 or /task_categories/1.json
  def destroy
    @task_category.destroy
    respond_to do |format|
      format.html { redirect_to task_categories_url, notice: 'Task category was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_task_category
    @task_category = TaskCategory.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def task_category_params
    params.require(:task_category).permit(:category)
  end
end
