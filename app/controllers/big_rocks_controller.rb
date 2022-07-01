# frozen_string_literal: true

# BigRocks
class BigRocksController < ApplicationController
  before_action :authenticate_user!
  before_action :set_big_rock, only: %i[show edit update destroy]

  # GET /big_rocks or /big_rocks.json
  def index
    @big_rocks = BigRock.all
    @quaters = BigRock.rock_groups
    # render json: @quaters
  end

  # GET /big_rocks/1 or /big_rocks/1.json
  def show; end

  # GET /big_rocks/new
  def new
    @big_rock = BigRock.new
  end

  # GET /big_rocks/1/edit
  def edit; end

  # POST /big_rocks or /big_rocks.json
  def create
    @big_rock = BigRock.new(big_rock_params)

    respond_to do |format|
      if @big_rock.save
        format.html { redirect_to @big_rock, notice: 'Big rock was successfully created.' }
        format.json { render :show, status: :created, location: @big_rock }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @big_rock.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /big_rocks/1 or /big_rocks/1.json
  def update
    respond_to do |format|
      if @big_rock.update(big_rock_params)
        format.html { redirect_to @big_rock, notice: 'Big rock was successfully updated.' }
        format.json { render :show, status: :ok, location: @big_rock }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @big_rock.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /big_rocks/1 or /big_rocks/1.json
  def destroy
    @big_rock.destroy
    respond_to do |format|
      format.html { redirect_to big_rocks_url, notice: 'Big rock was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_big_rock
    @big_rock = BigRock.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def big_rock_params
    params.require(:big_rock).permit(:owner, :category, :quater, :year, :rock, :status)
  end
end
