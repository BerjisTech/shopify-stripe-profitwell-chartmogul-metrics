# frozen_string_literal: true

ActiveAdmin.register AppGroup do
  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  # permit_params :group_name, :group_description, :user_id
  #
  # or
  #
  # permit_params do
  #   permitted = [:group_name, :group_description, :user_id]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end
end
