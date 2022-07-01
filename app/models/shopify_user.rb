# frozen_string_literal: true

# ShopifyUser
# rubocop:disable Metrics/MethodLength
class ShopifyUser < ApplicationRecord
  def self.data(api, time, cursor)
    "{app(id: \"gid://partners/App/#{api.app_code}\") {
          id
          name
          events(
              first: 100,
              after: \"#{cursor}\",
              types: [RELATIONSHIP_REACTIVATED RELATIONSHIP_DEACTIVATED
                RELATIONSHIP_INSTALLED RELATIONSHIP_UNINSTALLED],
              occurredAtMin: \"#{time[:start]}\",
              occurredAtMax: \"#{time[:end]}\"
              ) {
                  edges {
                      cursor
                      node {
                          type
                          occurredAt
                          shop {
                              id,
                              myshopifyDomain
                          }
                          ... on RelationshipUninstalled {
                              reason
                              description
                          }
                      }
                  }
                  pageInfo {
                      hasPreviousPage
                      hasNextPage
                  }
              }
          }
      }"
  end

  def self.total_installs(processed_data)
    installs = processed_data.select { |i, _v| i['node']['type'] == 'RELATIONSHIP_INSTALLED' }.size
  end

  def self.total_uninstalls(processed_data)
    uninstalls = processed_data.select { |i, _v| i['node']['type'] == 'RELATIONSHIP_UNINSTALLED' }.size
  end

  def self.total_deactivations(processed_data)
    deactivations = processed_data.select { |i, _v| i['node']['type']  == 'RELATIONSHIP_DEACTIVATED' }.size
  end

  def self.total_reactivations(processed_data)
    reactivations = processed_data.select { |i, _v| i['node']['type']  == 'RELATIONSHIP_REACTIVATED' }.size
  end

  def self.calculate_users(processed_data)
    { new_subscriptions: ShopifyUser.total_installs(processed_data),
      closed_subscription: ShopifyUser.total_uninstalls(processed_data),
      deactivations: ShopifyUser.total_deactivations(processed_data),
      reactivations: ShopifyUser.total_reactivations(processed_data) }
  end
end

# rubocop:enable Metrics/MethodLength
