# frozen_string_literal: true

ActiveAdmin.register TaskLog do
  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  # permit_params :task, :log, :operator
  #
  # or
  #
  # permit_params do
  #   permitted = [:task, :log, :operator]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end
end
