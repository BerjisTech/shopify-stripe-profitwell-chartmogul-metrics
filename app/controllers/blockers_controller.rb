# frozen_string_literal: true

class BlockersController < ApplicationController
  before_action :set_blocker, only: %i[show edit update destroy]

  # GET /blockers or /blockers.json
  def index
    @blockers = Blocker.all
  end

  # GET /blockers/1 or /blockers/1.json
  def show; end

  # GET /blockers/new
  def new
    @blocker = Blocker.new
  end

  # GET /blockers/1/edit
  def edit; end

  # POST /blockers or /blockers.json
  def create
    @blocker = Blocker.new(blocker_params)

    respond_to do |format|
      if @blocker.save
        format.html { redirect_to @blocker, notice: 'Blocker was successfully created.' }
        format.json { render :show, status: :created, location: @blocker }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @blocker.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /blockers/1 or /blockers/1.json
  def update
    respond_to do |format|
      if @blocker.update(blocker_params)
        format.html { redirect_to @blocker, notice: 'Blocker was successfully updated.' }
        format.json { render :show, status: :ok, location: @blocker }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @blocker.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /blockers/1 or /blockers/1.json
  def destroy
    @blocker.destroy
    respond_to do |format|
      format.html { redirect_to blockers_url, notice: 'Blocker was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_blocker
    @blocker = Blocker.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def blocker_params
    params.require(:blocker).permit(:item, :added_by)
  end
end
