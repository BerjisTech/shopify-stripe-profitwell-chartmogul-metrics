# frozen_string_literal: true

class StripeDatum < ApplicationRecord
  class << self
    def initate_import(app_id, time)
      api = Api.find_by(app_id: app_id, name: 'Stripe')
      secret = api.secret

      format_data(secret, time, '', [])
    end

    def format_data(secret, time, last_point, customers)
      Stripe.api_key = secret
      stripe_data = if last_point.present?
                      Stripe::Customer.list(
                        {
                          limit: 100_000,
                          starting_after: last_point,
                          created: {
                            gt: time[:start].to_time.to_i,
                            lte: time[:end].to_time.to_i
                          }
                        }
                      )
                    else
                      Stripe::Customer.list(
                        {
                          limit: 100_000,
                          created: {
                            gt: time[:start].to_time.to_i,
                            lte: time[:end].to_time.to_i
                          }
                        }
                      )
                    end

      p "appending #{stripe_data['data'].count} nodes"
      customers = append_extras(customers, stripe_data['data'])
      if stripe_data['has_more'].present?
        last_point = stripe_data['data'].last['id']
        format_data(secret, time, last_point, customers)
      else
        p "fetched #{customers.count} customers"
        Metric.format_stripe_users(customers, time)
        # p "#{customers}"
      end
    end

    def append_extras(customers, stripe_data)
      stripe_data.map do |node|
        p "appending #{node.id}"
        customers << node
      end
      customers
    end

    def stripe_trials(app_id)
      api = Api.find_by(app_id: app_id, name: 'Stripe')
      secret = api.secret

      Stripe.api_key = secret

      current_customers = Stripe::Customer.list(
        {
          limit: 100_000,
          created: {
            gt: (Date.today - 1.days).to_time.to_i,
            lte: Date.today.to_time.to_i
          }
        }
      )

      customer_count = current_customers['data'].count

      if current_customers['has_more'].present?
      end
    end

    def playground(app, time)
      api = Api.find_by(app_id: app.id, name: 'Stripe')
      secret = api.secret

      Stripe.api_key = secret
      get_users(app, time, '', 0)
    end

    def stripe_trial(app, time)
      api = Api.find_by(app_id: app.id, name: 'Stripe')
      secret = api.secret

      Stripe.api_key = secret
      get_users(app, time, '', 0)
    end

    def get_users(app, time, last_point, c_count = 0)
      c = if last_point.present?
            Stripe::Customer.list(
              {
                limit: 100_000,
                starting_after: last_point,
                created: {
                  gt: time[:start].to_time.to_i,
                  lte: time[:end].to_time.to_i
                }
              }
            )
          else
            Stripe::Customer.list(
              {
                limit: 100_000,
                created: {
                  gt: time[:start].to_time.to_i,
                  lte: time[:end].to_time.to_i
                }
              }
            )
          end

      new_count = if app.tag.upcase == 'SK'
                    c['data'].count
                  else
                    c['data'].select do |node, _value|
                      node['subscriptions'].present? && node['subscriptions']['data'].present? && node['subscriptions']['data'][0]['status'] == 'trialing'
                    end.count
                  end
      count = new_count + c_count
      p count
      display_new_users(app, time, c, count)
    end

    def display_new_users(app, time, c, count)
      if c['has_more'].present?
        last_point = c['data'].last['id']
        get_users(app, time, last_point, count)
      else
        count
      end
    end
  end
end
