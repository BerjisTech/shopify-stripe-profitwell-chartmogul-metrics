# frozen_string_literal: true

class SlacksController < ApplicationController
  before_action :set_slack, only: %i[show edit update destroy]
  skip_before_action :verify_authenticity_token

  # GET /slacks or /slacks.json
  def index
    headers = {
      'content-type': 'application/json;charset=UTF-8',
      'Authorization': "Bearer #{SlackApi.first.current_bot_token}"
    }
    body = {
      "token": SlackApi.first.current_bot_token,
      "channel": 'C02AMTWQAUU',
      "text": Slack.mrr
    }
    render json: Slack.send_message(body, headers)
  end

  # GET /slacks/1 or /slacks/1.json
  def show; end

  # GET /slacks/new
  def new
    @slack = Slack.new
  end

  # GET /slacks/1/edit
  def edit; end

  def events
    Error.create(error: Slack.slash_event_test(params), origin: request.referrer, controller: params[:controller],
                 method: params[:action])
    render json: params
  end

  def install
    slack_auth = Faraday.post(
      'https://slack.com/api/oauth.v2.access',
      {
        code: params[:code],
        client_id: SlackApi.first.client_id,
        client_secret: SlackApi.first.client_secret
      },
      {}
    ).body

    json_slack = JSON.parse(slack_auth)
    slack_table = OpenStruct.new json_slack

    redirect_to slack_table.incoming_webhook['configuration_url']
  end

  # TODO: Filter payload
  # token=gIkuvaNzQIHg97ATvDxqgjtO
  # &team_id=T0001
  # &team_domain=example
  # &enterprise_id=E0001
  # &enterprise_name=Globular%20Construct%20Inc
  # &channel_id=C2147483705
  # &channel_name=test
  # &user_id=U2147483697
  # &user_name=Steve
  # &command=/weather
  # &text=94070
  # &response_url=https://hooks.slack.com/commands/1234/5678
  # &trigger_id=13345224609.738474920.8088930838d88f008e0
  # &api_app_id=A123456
  def mrr
    render json: Slack.mrr
  end

  def contest
    render json: Slack.contest
  end

  def slash_event_test
    render json: Slack.slash_event_test(params)
  end

  def interact; end

  # POST /slacks or /slacks.json
  def create
    @slack = Slack.new(slack_params)

    respond_to do |format|
      if @slack.save
        format.html { redirect_to @slack, notice: 'Slack was successfully created.' }
        format.json { render :show, status: :created, location: @slack }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @slack.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /slacks/1 or /slacks/1.json
  def update
    respond_to do |format|
      if @slack.update(slack_params)
        format.html { redirect_to @slack, notice: 'Slack was successfully updated.' }
        format.json { render :show, status: :ok, location: @slack }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @slack.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /slacks/1 or /slacks/1.json
  def destroy
    @slack.destroy
    respond_to do |format|
      format.html { redirect_to slacks_url, notice: 'Slack was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_slack
    @slack = Slack.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def slack_params
    params.require(:slack).permit(:event)
  end
end
