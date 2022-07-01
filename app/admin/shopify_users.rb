# frozen_string_literal: true

ActiveAdmin.register ShopifyUser do
  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  # permit_params :shop_name, :shop_domain, :shop_email, :shop_country, :shop_plan, :install_date, :app_id
  #
  # or
  #
  # permit_params do
  #   permitted = [:shop_name, :shop_domain, :shop_email, :shop_country, :shop_plan, :install_date, :app_id]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end
end
