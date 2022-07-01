# frozen_string_literal: true

ActiveAdmin.register ShopifyPayment do
  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  # permit_params :date, :billing_period_start, :billing_period_end, :payment_duration, :shop_name, :shop_domain, :shop_email, :shop_country, :details, :charge_type, :partner_sale, :shopify_fee, :processing_fee, :partner_share, :charge_id, :app_id
  #
  # or
  #
  # permit_params do
  #   permitted = [:date, :billing_period_start, :billing_period_end, :payment_duration, :shop_name, :shop_domain, :shop_email, :shop_country, :details, :charge_type, :partner_sale, :shopify_fee, :processing_fee, :partner_share, :charge_id, :app_id]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end
end
