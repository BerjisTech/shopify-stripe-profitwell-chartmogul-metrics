# frozen_string_literal: true

# ToDos
class TodosController < ApplicationController
  before_action :authenticate_user!
  before_action :set_todo, only: %i[show edit update destroy]
  before_action :set_account

  # GET /todos or /todos.json
  def index
    @todos = if Account.editor(@account.user_id)
               Todo.all.order(deadline: :asc)
             else
               Todo.where(user_id: current_user.id).order(deadline: :asc)
             end
  end

  # GET /todos/1 or /todos/1.json
  def show; end

  # GET /todos/new
  def new
    @todo = Todo.new
  end

  # GET /todos/1/edit
  def edit; end

  # POST /todos or /todos.json
  def create
    @todo = Todo.new(todo_params)
    @todo.user_id = current_user.id
    @todo.deadline = DateTime.now if @todo.deadline.nil?
    @todo.done = 0

    if @todo.save
      'Todo was successfully created.'
    else
      @todo.errors
    end
  end

  # PATCH/PUT /todos/1 or /todos/1.json
  def update
    respond_to do |format|
      if @todo.update(todo_params)
        format.html { redirect_to @todo, notice: 'Todo was successfully updated.' }
        format.json { render :show, status: :ok, location: @todo }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @todo.errors, status: :unprocessable_entity }
      end
    end
  end

  def ajax_update
    Todo.where(id: params[:todo]).update_all(done: params[:state])
  end

  # DELETE /todos/1 or /todos/1.json
  def destroy
    @todo.destroy
    respond_to do |format|
      format.html { redirect_to todos_url, notice: 'Todo was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_todo
    @todo = Todo.find(params[:id])
  end

  def set_account
    @account = Account.find_by(user_id: current_user.id)
  end

  # Only allow a list of trusted parameters through.
  def todo_params
    params.require(:todo).permit(:user_id, :to_do, :deadline)
  end
end
