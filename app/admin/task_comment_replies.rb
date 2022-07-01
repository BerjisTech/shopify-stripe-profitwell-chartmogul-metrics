# frozen_string_literal: true

ActiveAdmin.register TaskCommentReply do
  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  # permit_params :reply, :task_comment_id, :user_id, :task_id
  #
  # or
  #
  # permit_params do
  #   permitted = [:reply, :task_comment_id, :user_id, :task_id]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end
end
