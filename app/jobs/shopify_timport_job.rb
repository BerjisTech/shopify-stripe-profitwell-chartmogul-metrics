# frozen_string_literal: true

class ShopifyTimportJob < ApplicationJob
  queue_as :default

  def perform(app_id, data_set, time_start, time_end, span)
    # Do something later
    Shopify.cron_import(app_id, data_set, time_start, time_end, span)
  end
end
