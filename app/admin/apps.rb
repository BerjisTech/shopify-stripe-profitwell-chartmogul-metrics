# frozen_string_literal: true

ActiveAdmin.register App do
  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  # permit_params :app_name, :app_code, :partner_id, :api_key, :secondary_api_key, :app_group_id, :data_point, :tag, :platform_id
  #
  # or
  #
  # permit_params do
  #   permitted = [:app_name, :app_code, :partner_id, :api_key, :secondary_api_key, :app_group_id, :data_point, :tag, :platform_id]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end
end
