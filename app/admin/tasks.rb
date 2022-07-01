# frozen_string_literal: true

ActiveAdmin.register Task do
  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  # permit_params :assigned_by, :assigned_to, :task, :description, :deadline, :done, :app_id, :is_blocker, :category, :resources, :task_type, :stage, :is_priority, :state
  #
  # or
  #
  # permit_params do
  #   permitted = [:assigned_by, :assigned_to, :task, :description, :deadline, :done, :app_id, :is_blocker, :category, :resources, :task_type, :stage, :is_priority, :state]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end
end
