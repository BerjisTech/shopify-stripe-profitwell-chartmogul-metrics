# frozen_string_literal: true

# Funds
class AppGroupsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_app_group, only: %i[show fund edit update destroy]
  before_action :set_fund_data, only: %i[show fund]

  # GET /app_groups or /app_groups.json
  def index
    @app_groups = AppGroup.all
  rescue NoMethodError => e
    Rollbar.info(e, @app_groups.errors)
  end

  # GET /app_groups/1 or /app_groups/1.json
  def show
    session[:current_app_group] = @app_group.id
    @fund_mrr_data = OpenStruct.new AppGroup.fund_mrr(@app_group.id)
  end

  # GET /app_groups/new
  def new
    @app_group = AppGroup.new
  end

  # GET /app_groups/1/edit
  def edit; end

  # POST /app_groups or /app_groups.json
  def create
    @app_group = AppGroup.new(app_group_params)

    respond_to do |format|
      if @app_group.save
        format.html { redirect_to @app_group, notice: 'App group was successfully created.' }
        format.json { render :show, status: :created, location: @app_group }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @app_group.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /app_groups/1 or /app_groups/1.json
  def update
    respond_to do |format|
      if @app_group.update(app_group_params)
        format.html { redirect_to @app_group, notice: 'App group was successfully updated.' }
        format.json { render :show, status: :ok, location: @app_group }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @app_group.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /app_groups/1 or /app_groups/1.json
  def destroy
    @app_group.destroy
    respond_to do |format|
      format.html { redirect_to app_groups_url, notice: 'App group was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_app_group
    @app_group = if params[:fund].present?
                   AppGroup.find_by(group_name: "Fund #{params[:fund]}")
                 else
                   AppGroup.find(params[:id])
                 end
    redirect_to funds_path if @app_group.nil?
  end

  def set_fund_data
    @fund_mrr = AppGroup.latest_mrr(@app_group.id)
    @fund_trial = AppGroup.latest_trial(@app_group.id)
    @fund_users = AppGroup.latest_users(@app_group.id)
    @fund_members = AppGroup.members(@app_group.id)
  end

  # Only allow a list of trusted parameters through.
  def app_group_params
    params.require(:app_group).permit(:group_name, :group_description, :user_id)
  end
end
