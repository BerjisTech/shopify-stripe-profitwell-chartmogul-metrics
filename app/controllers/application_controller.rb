# frozen_string_literal: true

# Application
class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  # respond_to :json

  def after_sign_in_path_for(_resource)
    dashboard_path
  end

  def after_sign_up_path_for(_resource)
    account_path(current_user.id)
  end

  def after_sign_out_path_for(_resource_or_scope)
    reset_session
    request.referrer || root_path
  end

  def account_session
    account = Account.find_by(user_id: current_user.id)

    if account.nil?
      @account = Account.new(user_id: current_user.id, role_id: Role.find_by(name: 'Customer Hero').id)
      if @account.save
        redirect_to edit_account_path(@account), notice: 'Setup your account to be able to fully use the system'
      else
        Rollbar.error(@account.errors)
        render json: @account.errors
      end
    end
  end
end
