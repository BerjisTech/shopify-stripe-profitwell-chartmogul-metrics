# frozen_string_literal: true

class EventsController < ApplicationController
  before_action :authenticate_user!, except: %i[api]
  before_action :set_event, only: %i[show edit update destroy]
  # skip_before_action :verify_authenticity_token, only: %i[api]

  # GET /events or /events.json
  def index
    @events = Event.all
  rescue NoMethodError => e
    Rollbar.info(e, @events.errors)
  end

  # GET /events/1 or /events/1.json
  def show; end

  # GET /events/new
  def new
    @event = Event.new
  end

  # GET /events/1/edit
  def edit; end

  # POST /events or /events.json
  def create
    @event = Event.new(event_params)

    respond_to do |format|
      if @event.save
        format.html { redirect_to @event, notice: 'Event was successfully created.' }
        format.json { render :show, status: :created, location: @event }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /events/1 or /events/1.json
  def update
    respond_to do |format|
      if @event.update(event_params)
        format.html { redirect_to @event, notice: 'Event was successfully updated.' }
        format.json { render :show, status: :ok, location: @event }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /events/1 or /events/1.json
  def destroy
    @event.destroy
    respond_to do |format|
      format.html { redirect_to events_url, notice: 'Event was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def api
    token = Digest::SHA1.hexdigest('LTV_SAAS_GROWTH_EVENTS')

    if params['token'].blank?
      message = { error: 'Token cannot be blank' }
    elsif params['token'].empty?
      message = { error: 'Token cannot be empty' }
    elsif params['token'].nil?
      message = { error: 'Token cannot be nil or null' }
    elsif params['token'] != token
      message = { error: 'Invalid token' }
    else
      check_errors = check_params(params)

      if check_errors.nil?
        verify_app = check_app(params)
        message = verify_app
      else
        message = { error: check_errors }
      end
    end

    render json: message
  end

  private

  def check_app(params)
    app = App.find_by(app_code: params['app_id'])

    if app.nil?
      { error: 'This app does not exist in the DB' }
    else
      Event.find_or_create_by(
        app_id: app.id,
        website: params['website'],
        email: params['email'],
        event: params['event'],
        time: DateTime.now
      )
      { message: 'Succesfully saved event' }
    end
  end

  def check_params(params)
    message = []

    message << 'app_id cannot be blank' if params['app_id'].blank?
    message << 'website cannot be blank' if params['website'].blank?
    message << 'email cannot be blank' if params['email'].blank?
    message << 'event cannot be blank' if params['event'].blank?
    message << 'time cannot be blank' if params['time'].blank?
  end

  # Use callbacks to share common setup or constraints between actions.
  def set_event
    @event = Event.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def event_params
    params.require(:event).permit(:app_id, :website, :email, :event, :time)
  end
end
