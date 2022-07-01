# frozen_string_literal: true

ActiveAdmin.register Webhook do
  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  # permit_params :origin, :app_id, :platform, :slag
  #
  # or
  #
  # permit_params do
  #   permitted = [:origin, :app_id, :platform, :slag]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end
end
