# frozen_string_literal: true

ActiveAdmin.register Contest do
  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  # permit_params :request_price, :received_price, :chat_price, :call_price, :app_id, :platform_id, :period_start, :period_end
  #
  # or
  #
  # permit_params do
  #   permitted = [:request_price, :received_price, :chat_price, :call_price, :app_id, :platform_id, :period_start, :period_end]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end
end
