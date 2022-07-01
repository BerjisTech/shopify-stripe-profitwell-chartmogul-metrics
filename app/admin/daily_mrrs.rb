# frozen_string_literal: true

ActiveAdmin.register DailyMrr do
  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  # permit_params :app_id, :level, :amount, :trial, :arr, :date, :unixdate
  #
  # or
  #
  # permit_params do
  #   permitted = [:app_id, :level, :amount, :trial, :arr, :date, :unixdate]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end
end
