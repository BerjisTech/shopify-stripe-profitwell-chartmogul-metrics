# frozen_string_literal: true

# Shopify
# rubocop:disable Metrics/AbcSize
# rubocop:disable Metrics/ClassLength
# rubocop:disable Metrics/MethodLength
# rubocop:disable Metrics/CyclomaticComplexity
# rubocop:disable Metrics/PerceivedComplexity
class Shopify < ApplicationRecord
  class << self
    def cron_import(app_id, data_set, time_start, time_end, span)
      time = if span == 'month'
               { start: (DateTime.now - 30.days).to_s, end: DateTime.now.to_s, span: span }
             else
               { start: (DateTime.now - 1.days).to_s, end: DateTime.now.to_s, span: span }
             end

      time[:start] = (DateTime.now - time_start.to_i.days).to_s if time_start.present?
      time[:end] = (DateTime.now - time_end.to_i.days).to_s if time_end.present?

      Shopify.run_importer(App.find(app_id), data_set, time, '')
    end

    def run_importer(app, data_set, time, cursor = '')
      api = Api.find_by(app_id: app.id, name: 'Shopify Partner API')
      data = pick_importer(app, api, data_set, time, cursor)

      process_data(data, app, time)
    end

    def pick_importer(_app, api, data_set, time, cursor)
      case data_set
      when 'user'
        data_importer(api, ShopifyUser.data(api, time, cursor))
      when 'financials'
        data_importer(api, ShopifyPayment.data(time, cursor))
      end
    end

    def data_importer(api, body)
      path = "https://partners.shopify.com/#{api.partner_id}/api/2021-10/graphql.json"
      header = {
        'Content-Type': 'application/graphql',
        'X-Shopify-Access-Token': api.key
      }
      Faraday.post(path, body, header).body
    end

    def process_data(data, app, time)
      if data.blank?
        missing_data(app)
      else
        filter_data(JSON.parse(data), app, time)
      end
    end

    def missing_data(app)
      {
        status: '500',
        app: app.id,
        cursor: 'DONE',
        message: 'No data received'
      }
    end

    def filter_data(fetched_data, app, time)
      required_data = pull_required_data(fetched_data)

      pages = { next: '', back: '' }
      cursor = { next: '', back: '' }
      pages[:next] = required_data['pageInfo']['hasNextPage']
      pages[:back] = required_data['pageInfo']['hasPreviousPage']
      processed_data = required_data['edges']

      cursor = define_cursors(processed_data, cursor) if processed_data.count.positive?
      empty_data_set(pages, app) unless processed_data.count.positive?

      pull_extra_data(app, time, fetched_data, required_data, cursor[:next]) if pages[:next] == true

      upsert_metrics_table(processed_data, pages, app, cursor, time)
    end

    def pull_extra_data(app, time, fetched_data, required_data, cursor)
      processed_data = required_data['edges']
      api = Api.find_by(app_id: app.id, name: 'Shopify Partner API')

      if processed_data.first['node'].key?('type')
        extra_data = JSON.parse(data_importer(api,
                                              ShopifyUser.data(api, time,
                                                               cursor)))
      end

      if processed_data.first['node'].key?('netAmount')
        extra_data = JSON.parse(data_importer(api,
                                              ShopifyPayment.data(time,
                                                                  cursor)))
      end

      if extra_data.present? && extra_data['data'].present?
        if extra_data['data'].key?('app')
          extra_data['data']['app']['events']['edges'].map do |edge|
            fetched_data['data']['app']['events']['edges'] << edge
          end
        end

        if extra_data['data'].key?('transactions')
          extra_data['data']['transactions']['edges'].map do |edge|
            fetched_data['data']['transactions']['edges'] << edge
          end
        end
        update_page_info(fetched_data, extra_data)
      end
      filter_data(fetched_data, app, time)
    end

    def update_page_info(fetched_data, extra_data)
      if extra_data['data'].key?('app')
        fetched_data['data']['app']['events']['pageInfo']['hasNextPage'] =
          extra_data['data']['app']['events']['pageInfo']['hasNextPage']
      end
      if extra_data['data'].key?('transactions')
        fetched_data['data']['transactions']['pageInfo']['hasNextPage'] =
          extra_data['data']['transactions']['pageInfo']['hasNextPage']
      end
    end

    def append_edges(processed_data, extra_data)
      extra_data.map do |edge|
        processed_data << edge
      end
    end

    def empty_data_set(pages, app)
      {
        'Next Page': pages[:next], 'Next Cursor': '', 'Back Page': pages[:back], 'Back Cursor': '',
        'DB Stage': {
          'rows': 'none found',
          'message': {
            'status': '500', 'app': app.id, 'cursor': 'DONE', 'message': 'empty'
          }
        }
      }
    end

    def pull_required_data(fetched_data)
      fetched_data = OpenStruct.new fetched_data
      if fetched_data['data'].key?('app')
        fetched_data['data']['app']['events']
      elsif fetched_data['data'].key?('transactions')
        fetched_data['data']['transactions']
      end
    end

    def define_cursors(processed_data, cursor)
      cursor[:next] = processed_data.last['cursor'] if processed_data.count.positive?
      cursor[:back] = processed_data.first['cursor'] if processed_data.count.positive?
      cursor
    end

    def upsert_metrics_table(processed_data, _pages, app, _cursor, time)
      db_data(processed_data, app, time)
    end

    def db_data(processed_data, app, time)
      if processed_data.first['node'].key?('type')
        create_metric(ShopifyUser.calculate_users(processed_data), app, time[:end])
      elsif processed_data.first['node'].key?('netAmount')
        if time[:span] == 'day'
          create_metric(ShopifyPayment.calculate_daily_financials(processed_data), app,
                        time[:end])
        end
        create_metric(ShopifyPayment.calculate_net_mrr(processed_data), app, time[:end]) if time[:span] == 'month'
      end
    end

    def create_metric(metric, app, date)
      metric_id = Metric.find_or_create_by(app_id: app.id, date: Date.parse(date).strftime('%d-%m-%Y')).id
      Metric.where(id: metric_id).update_all(metric)
      Metric.find(metric_id)
    end
  end
end
# rubocop:enable Metrics/PerceivedComplexity
# rubocop:enable Metrics/CyclomaticComplexity
# rubocop:enable Metrics/MethodLength
# rubocop:enable Metrics/ClassLength
# rubocop:enable Metrics/AbcSize
