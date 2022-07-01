# frozen_string_literal: true

ActiveAdmin.register TaskChecklist do
  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  # permit_params :task_id, :item, :status, :added_by
  #
  # or
  #
  # permit_params do
  #   permitted = [:task_id, :item, :status, :added_by]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end
end
