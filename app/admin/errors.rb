# frozen_string_literal: true

ActiveAdmin.register Error do
  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  # permit_params :error, :origin, :controller, :method
  #
  # or
  #
  # permit_params do
  #   permitted = [:error, :origin, :controller, :method]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end
end
