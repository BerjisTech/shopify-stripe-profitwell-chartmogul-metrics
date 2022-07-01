# frozen_string_literal: true

# ShopifyPayment

# APP_SUBSCRIPTION_SALE APP_USAGE_SALE APP_SALE_ADJUSTMENT

# rubocop:disable Metrics/MethodLength
# rubocop:disable Metrics/AbcSize
# rubocop:disable Metrics/ClassLength
class ShopifyPayment < ActiveRecord::Base
  def self.data(time, cursor)
    "{
        transactions (
            first: 100
            types: [APP_SUBSCRIPTION_SALE APP_USAGE_SALE APP_SALE_ADJUSTMENT],
            after: \"#{cursor}\",
            createdAtMin: \"#{time[:start]}\",
            createdAtMax: \"#{time[:end]}\", ) {
                edges {
                    cursor
                    node {
                        id,
                        createdAt,
                        ... on AppSubscriptionSale {
                            netAmount {
                                amount
                            },
                            app {
                                name
                            },
                            shop {
                                id,
                                myshopifyDomain
                            }
                        },
                        ... on AppUsageSale {
                            netAmount {
                                amount
                            },
                            app {
                                name
                            },
                            shop {
                                id,
                                myshopifyDomain
                            }
                        },
                        ... on ServiceSale {
                            netAmount {
                                amount
                            },
                            shop {
                                myshopifyDomain
                            }
                        },
                        ... on AppSaleAdjustment {
                            netAmount {
                                amount
                            },
                            app {
                                name
                            },
                            shop {
                                id,
                                myshopifyDomain
                            }
                        },
                    }
                },
                pageInfo {
                    hasPreviousPage
                    hasNextPage
                }
            }
        }"
  end

  def self.calculate_daily_financials(processed_data)
    total = 0
    recurring = 0
    one_time = 0
    refund = 0
    processed_data.each do |transaction|
      total += transaction['node']['netAmount']['amount'].to_f
      if transaction['node']['id'].include?('gid://partners/AppUsageSale/')
        one_time += transaction['node']['netAmount']['amount'].to_f
      end
      if transaction['node']['id'].include?('gid://partners/AppSubscriptionSale/')
        recurring += transaction['node']['netAmount']['amount'].to_f
      end
      if transaction['node']['id'].include?('gid://partners/AppSaleAdjustment/')
        refund += transaction['node']['netAmount']['amount'].to_f
      end
    end
    {
      recurring_revenue: recurring,
      one_time_charge: one_time,
      refunds: refund
    }
  end

  def self.calculate_net_mrr(processed_data)
    total = 0
    recurring = 0
    one_time = 0
    refund = 0
    processed_data.each do |transaction|
      total += transaction['node']['netAmount']['amount'].to_f
      if transaction['node']['id'].include?('gid://partners/AppUsageSale/')
        one_time += transaction['node']['netAmount']['amount'].to_f
      end
      if transaction['node']['id'].include?('gid://partners/AppSubscriptionSale/')
        recurring += transaction['node']['netAmount']['amount'].to_f
      end
      if transaction['node']['id'].include?('gid://partners/AppSaleAdjustment/')
        refund += transaction['node']['netAmount']['amount'].to_f
      end
    end
    {
      mrr: total,
      net_revenue: (total - refund)
    }
  end
end

# rubocop:enable Metrics/ClassLength
# rubocop:enable Metrics/AbcSize
# rubocop:enable Metrics/MethodLength
