# frozen_string_literal: true

class CallsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_call, only: %i[show edit update destroy]
  # before_action :stop_that, only: %i[edit update destroy]

  # GET /calls or /calls.json
  def index
    @calls = if Account.editor(current_user.id)
               Call.all
             else
               Call.where(user_id: current_user.id)
             end
  rescue NoMethodError => e
    Rollbar.info(e, @calls.errors)
  end

  # GET /calls/1 or /calls/1.json
  def show; end

  # GET /calls/new
  def new
    @call = Call.new
  end

  # GET /calls/1/edit
  def edit; end

  # POST /calls or /calls.json
  def create
    @call = Call.new(call_params)

    respond_to do |format|
      if @call.save
        format.html { redirect_to @call, notice: 'Call was successfully created.' }
        format.json { render :show, status: :created, location: @call }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @call.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /calls/1 or /calls/1.json
  def update
    respond_to do |format|
      if @call.update(call_params)
        format.html { redirect_to @call, notice: 'Call was successfully updated.' }
        format.json { render :show, status: :ok, location: @call }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @call.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /calls/1 or /calls/1.json
  def destroy
    @call.destroy
    respond_to do |format|
      format.html { redirect_to calls_url, notice: 'Call was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_call
    @call = Call.find(params[:id])
  end

  def stop_that
    if Account.editor(current_user.id)
      @account = Account.find_by(user_id: current_user.id)
    else
      redirect_to 'https://www.youtube.com/watch?v=dQw4w9WgXcQ&ab_channel=RickAstley'
    end
  end

  # Only allow a list of trusted parameters through.
  def call_params
    params.require(:call).permit(:app_id, :user_id, :ticket, :comment, :date)
  end
end
