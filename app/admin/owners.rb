# frozen_string_literal: true

ActiveAdmin.register Owner do
  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  # permit_params :app_id, :user_id, :level, :status
  #
  # or
  #
  # permit_params do
  #   permitted = [:app_id, :user_id, :level, :status]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end
end
