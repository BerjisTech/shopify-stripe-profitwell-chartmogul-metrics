# frozen_string_literal: true

# OwnersController
# rubocop:disable Metrics/AbcSize
# rubocop:disable Metrics/MethodLength
class OwnersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_owner, only: %i[show edit update destroy]

  # GET /owners or /owners.json
  def index
    @owners = Owner.group(:app_id).select(:app_id)
  rescue NoMethodError => e
    Rollbar.info(e, @owners.errors)
  end

  # GET /owners/1 or /owners/1.json
  def show; end

  # GET /owners/new
  def new
    @owner = Owner.new
  end

  # GET /owners/1/edit
  def edit; end

  # POST /owners or /owners.json
  def create
    @owner = Owner.new(owner_params)

    respond_to do |format|
      if Owner.find_by(user_id: @owner.user_id, app_id: @owner.app_id).present?
        format.html do
          redirect_to admin_path,
                      notice: "#{Account.find_by(user_id: @owner.user_id).first_name} is already a member of #{App.find(@owner.app_id).app_name}"
        end
        format.json { render :show, status: :created, location: @owner }
      elsif @owner.app_id.nil?
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @owner.errors, status: :unprocessable_entity }
      elsif @owner.save
        format.html { redirect_to @owner, notice: 'Owner was successfully created.' }
        format.json { render :show, status: :created, location: @owner }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @owner.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /owners/1 or /owners/1.json
  def update
    respond_to do |format|
      if @owner.update(owner_params)
        format.html { redirect_to @owner, notice: 'Owner was successfully updated.' }
        format.json { render :show, status: :ok, location: @owner }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @owner.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /owners/1 or /owners/1.json
  def destroy
    @owner.destroy
    respond_to do |format|
      format.html { redirect_to owners_url, notice: 'Owner was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_owner
    @owner = Owner.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def owner_params
    params.require(:owner).permit(:app_id, :user_id, :level, :status)
  end
end

# rubocop:enable Metrics/MethodLength
# rubocop:enable Metrics/AbcSize
