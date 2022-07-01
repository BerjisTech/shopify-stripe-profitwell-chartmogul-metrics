# frozen_string_literal: true

ActiveAdmin.register Suggestion do
  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  # permit_params :user_id, :app_id, :suggestion
  #
  # or
  #
  # permit_params do
  #   permitted = [:user_id, :app_id, :suggestion]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end
end
