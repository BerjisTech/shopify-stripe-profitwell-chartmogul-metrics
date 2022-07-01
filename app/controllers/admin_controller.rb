# frozen_string_literal: true

# Admin Contoller
class AdminController < ApplicationController
  before_action :authenticate_user!
  before_action :check_admin

  SHOPIFY_APPS = [
    'Product Customizer',
    'In Cart Upsell',
    'TrackifyX',
    'Preorder Now',
    'Bulk Discount Now',
    'Wholesale Pricing Now',
    'Sticky Add To Cart Booster',
    'Preorderly',
    'Upselly',
    'Sales Rocket'
  ].freeze

  def index; end

  def roles
    @roles = Role.all
  end

  def update_direct_report
    direct_report = params[:direct_report]
    user_id = params[:user_id]
    Account.where(user_id: user_id).update(direct_report: direct_report)
    render json: { message: 'Direct report updated succesfully', type: 'Info' }
  end

  def add_role
    Role.create(name: params[:role])
  end

  def check_admin
    if Account.find_by(user_id: current_user.id).role_id != Role.find_by(name: 'Admin').id # rubocop:disable Style/GuardClause
      redirect_to root_path, notice: 'Stick to your lane bruh'
    end
  end
end
