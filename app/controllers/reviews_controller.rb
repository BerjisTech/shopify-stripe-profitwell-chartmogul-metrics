# frozen_string_literal: true

# reviews Controller
class ReviewsController < ApplicationController
  before_action :authenticate_user!, except: %i[received]
  before_action :set_review, only: %i[show edit update destroy]
  # before_action :stop_that, only: %i[edit update destroy]
  skip_before_action :verify_authenticity_token, only: %i[received]
  skip_forgery_protection

  # GET /reviews or /reviews.json
  def index
    @reviews = if Account.editor(current_user.id)
                 Review.all
               else
                 Review.where(user_id: current_user.id)
               end
  rescue NoMethodError => e
    Rollbar.info(e, @reviews)
  end

  def received
    Error.create(
      error: params, origin: request.referer, controller: params['controller'], method: params['action']
    )
    render json: params
  end

  # GET /reviews/1 or /reviews/1.json
  def show; end

  # GET /reviews/new
  def new
    @review = Review.new
  end

  # GET /reviews/1/edit
  def edit; end

  # POST /reviews or /reviews.json
  def create
    @review = Review.new(review_params)

    respond_to do |format|
      if @review.save
        format.html { redirect_to @review, notice: 'Review was successfully created.' }
        format.json { render :show, status: :created, location: @review }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @review.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /reviews/1 or /reviews/1.json
  def update
    respond_to do |format|
      if @review.update(review_params)
        format.html { redirect_to @review, notice: 'Review was successfully updated.' }
        format.json { render :show, status: :ok, location: @review }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @review.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /reviews/1 or /reviews/1.json
  def destroy
    @review.destroy
    respond_to do |format|
      format.html { redirect_to reviews_url, notice: 'Review was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_review
    @review = Review.find(params[:id])
  end

  def stop_that
    if Account.editor(current_user.id)
      @account = Account.find_by(user_id: current_user.id)
    else
      redirect_to 'https://www.youtube.com/watch?v=dQw4w9WgXcQ&ab_channel=RickAstley'
    end
  end

  # Only allow a list of trusted parameters through.
  def review_params
    params.require(:review).permit(:app_id, :rating, :user_id, :ticket, :comment, :requested_on, :received_on, :type)
  end
end
