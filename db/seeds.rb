# frozen_string_literal: true

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# Role.destroy_all
# Role.create([{ name: 'Admin' },
#              { name: 'CEO' },
#              { name: 'COO' },
#              { name: 'Finance' },
#              { name: 'HR & Records' },
#              { name: 'Marketing' },
#              { name: 'Developer' },
#              { name: 'Snr Ops' },
#              { name: 'Jnr Ops' },
#              { name: 'Customer Hero' }])

# TaskStage.destroy_all

# TaskStage.create([
#                    { stage: 'Open' },
#                    { stage: 'Ongoing' },
#                    { stage: 'Feedback' },
#                    { stage: 'Testing' },
#                    { stage: 'Review' },
#                    { stage: 'Documentation' },
#                    { stage: 'Done' }
#                  ])

# AppGroup.destroy_all
# AppGroup.create([
#                   { group_name: 'Fund 5' },
#                   { group_name: 'Fund 6' },
#                   { group_name: 'Fund 7' }
#                 ])
#
# App.destroy_all
# App.create([
#              { app_name: 'Product Customizer', app_code: nil, partner_id: nil, api_key: nil, secondary_api_key: nil,
#                app_group_id: AppGroup.find_by(group_name: 'Fund 5').id, data_point: nil, tag: 'pc' },
#              { app_name: 'In Cart Upsell', app_code: nil, partner_id: nil, api_key: nil, secondary_api_key: nil,
#                app_group_id: AppGroup.find_by(group_name: 'Fund 6').id, data_point: nil, tag: 'icu' },
#              { app_name: 'TrackifyX', app_code: nil, partner_id: nil, api_key: nil, secondary_api_key: nil,
#                app_group_id: AppGroup.find_by(group_name: 'Fund 6').id, data_point: nil, tag: 'tfx' },
#              { app_name: 'Preorder Now', app_code: nil, partner_id: nil, api_key: nil, secondary_api_key: nil,
#                app_group_id: AppGroup.find_by(group_name: 'Fund 6').id, data_point: nil, tag: 'pon' },
#              { app_name: 'Bulk Discount Now', app_code: nil, partner_id: nil, api_key: nil, secondary_api_key: nil,
#                app_group_id: AppGroup.find_by(group_name: 'Fund 6').id, data_point: nil, tag: 'bdn' },
#              { app_name: 'Wholesale Pricing Now', app_code: nil, partner_id: nil, api_key: nil, secondary_api_key: nil,
#                app_group_id: AppGroup.find_by(group_name: 'Fund 6').id, data_point: nil, tag: 'wpn' },
#              { app_name: 'Sentrykit', app_code: nil, partner_id: nil, api_key: nil, secondary_api_key: nil,
#                app_group_id: AppGroup.find_by(group_name: 'Fund 7').id, data_point: nil, tag: 'sk' },
#              { app_name: 'Text2Give', app_code: nil, partner_id: nil, api_key: nil, secondary_api_key: nil,
#                app_group_id: AppGroup.find_by(group_name: 'Fund 7').id, data_point: nil, tag: 't2g' },
#              { app_name: 'Sticky Add To Cart Booster', app_code: nil, partner_id: nil, api_key: nil,
#                secondary_api_key: nil, app_group_id: AppGroup.find_by(group_name: 'Fund 7').id, data_point: nil, tag: 'satcb' },
#              { app_name: 'Preorderly', app_code: nil, partner_id: nil, api_key: nil, secondary_api_key: nil,
#                app_group_id: AppGroup.find_by(group_name: 'Fund 7').id, data_point: nil, tag: 'pdly' },
#              { app_name: 'Upselly', app_code: nil, partner_id: nil, api_key: nil, secondary_api_key: nil,
#                app_group_id: AppGroup.find_by(group_name: 'Fund 7').id, data_point: nil, tag: 'upsly' },
#              { app_name: 'Sales Rocket', app_code: nil, partner_id: nil, api_key: nil, secondary_api_key: nil,
#                app_group_id: AppGroup.find_by(group_name: 'Fund 7').id, data_point: nil, tag: 'sr' },
#              { app_name: 'Quetext', app_code: nil, partner_id: nil, api_key: nil, secondary_api_key: nil,
#                app_group_id: AppGroup.find_by(group_name: 'Fund 7').id, data_point: nil, tag: 'qt' }
#            ])
#
# Api.destroy_all
# Api.create([
#              {
#                app_id: App.find_by(tag: 'icu').id,
#                name: 'refersion',
#                key: 'pub_19cc3b1621b70ce1424a',
#                secret: 'sec_df5dbeec192b0a651783',
#                password: '',
#                secondary: '',
#                endpoint: '',
#                partner_id: nil,
#                app_code: nil
#              },
#              {
#                app_id: App.find_by(tag: 't2g').id,
#                name: 'ProfitWell',
#                key: '2d190739c58f87676c5c7a32174989e4',
#                secret: 'cd184a149fa49755eda4c5269a7cb5d4',
#                password: '',
#                secondary: '',
#                endpoint: 'https://api.profitwell.com/v2/',
#                partner_id: nil,
#                app_code: nil
#              },
#              {
#                app_id: App.find_by(tag: 'sk').id,
#                name: 'Chartmogul',
#                key: '50b35d08b60277f3cb4b10e1dd50d4d1',
#                secret: '31b2a2a00098bb88d558edaf5539cd29',
#                password: '',
#                secondary: '',
#                endpoint: '',
#                partner_id: nil,
#                app_code: nil
#              },
#              {
#                app_id: App.find_by(tag: 'qt').id,
#                name: 'Chartmogul',
#                key: '0b91e9fe1153b750abe1fc2e7b00f554',
#                secret: '94c8e984d52bac4af014e47406222f78',
#                password: '',
#                secondary: '',
#                endpoint: '',
#                partner_id: nil,
#                app_code: nil
#              },
#              {
#                app_id: App.find_by(tag: 'icu').id,
#                name: 'Shopify Partner API',
#                key: 'prtapi_dd62c28de4c131ac15ba31fe520882cb',
#                secret: '',
#                password: '',
#                secondary: 'prtapi_271c5ca57fdfdfc47af8992a64834512',
#                endpoint: '',
#                partner_id: '1322274',
#                app_code: '767045'
#              },
#              {
#                app_id: App.find_by(tag: 'pc').id,
#                name: 'Shopify Partner API',
#                key: 'prtapi_9f02250c591d3459d04bf8b4e4f54f17',
#                secret: '',
#                password: '',
#                secondary: 'prtapi_966b950694196e67deecaf9f1cfa05b2',
#                endpoint: '',
#                partner_id: '839642',
#                app_code: '133976'
#              },
#              {
#                app_id: App.find_by(tag: 'tfx').id,
#                name: 'Shopify Partner API',
#                key: 'prtapi_1b8766951a73aed29c128832f56fc1e8',
#                secret: '',
#                password: '',
#                secondary: 'prtapi_1f38c4743453aa4816c758668d90ccb0',
#                endpoint: '',
#                partner_id: '332808',
#                app_code: '838114'
#              },
#              {
#                app_id: App.find_by(tag: 'pon').id,
#                name: 'Shopify Partner API',
#                key: 'prtapi_f61edc0cbf5f5a79fd242f2fd8109f58',
#                secret: '',
#                password: '',
#                secondary: 'prtapi_cae598b313738493a199f9d447c101df',
#                endpoint: '',
#                partner_id: '490420',
#                app_code: '1635023'
#              },
#              {
#                app_id: App.find_by(tag: 'bdn').id,
#                name: 'Shopify Partner API',
#                key: 'prtapi_f61edc0cbf5f5a79fd242f2fd8109f58',
#                secret: '',
#                password: '',
#                secondary: 'prtapi_cae598b313738493a199f9d447c101df',
#                endpoint: '',
#                partner_id: '490420',
#                app_code: '1967466'
#              },
#              {
#                app_id: App.find_by(tag: 'wpn').id,
#                name: 'Shopify Partner API',
#                key: 'prtapi_f61edc0cbf5f5a79fd242f2fd8109f58',
#                secret: '',
#                password: '',
#                secondary: 'prtapi_cae598b313738493a199f9d447c101df',
#                endpoint: '',
#                partner_id: '490420',
#                app_code: '1883190'
#              },
#              {
#                app_id: App.find_by(tag: 'sr').id,
#                name: 'Shopify Partner API',
#                key: 'prtapi_5b986637ab7fc696218d2f2c2fdf448d',
#                secret: '',
#                password: '',
#                secondary: 'prtapi_ecbfb80d934da991eded8c5727db2ba6',
#                endpoint: '',
#                partner_id: '343188',
#                app_code: '975918'
#              },
#              {
#                app_id: App.find_by(tag: 'satcb').id,
#                name: 'Shopify Partner API',
#                key: 'prtapi_5b986637ab7fc696218d2f2c2fdf448d',
#                secret: '',
#                password: '',
#                secondary: 'prtapi_ecbfb80d934da991eded8c5727db2ba6',
#                endpoint: '',
#                partner_id: '343188',
#                app_code: '1236762'
#              },
#              {
#                app_id: App.find_by(tag: 'pdly').id,
#                name: 'Shopify Partner API',
#                key: 'prtapi_5b986637ab7fc696218d2f2c2fdf448d',
#                secret: '',
#                password: '',
#                secondary: 'prtapi_ecbfb80d934da991eded8c5727db2ba6',
#                endpoint: '',
#                partner_id: '343188',
#                app_code: '1906664'
#              },
#              {
#                app_id: App.find_by(tag: 'upsly').id,
#                name: 'Shopify Partner API',
#                key: 'prtapi_5b986637ab7fc696218d2f2c2fdf448d',
#                secret: '',
#                password: '',
#                secondary: 'prtapi_ecbfb80d934da991eded8c5727db2ba6',
#                endpoint: '',
#                partner_id: '343188',
#                app_code: '2378052'
#              },
#              {
#                app_id: App.find_by(tag: 'sk').id,
#                name: 'Stripe',
#                key: 'pk_live_51IiN5zCYSDSBygvjHlMVXP4xJwK3BGmNg0OInT2Dw7QiJv5jxHt3cTheowMg6cHeXpbs9OWGxpfU6WxeMO6NpkJp00RmGpHkzx',
#                secret: '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',
#                password: '',
#                secondary: '',
#                endpoint: '',
#                partner_id: '',
#                app_code: ''
#              },
#              {
#                app_id: App.find_by(tag: 'qt').id,
#                name: 'Stripe',
#                key: 'pk_live_Wf9kCMsOTvG3I3JAXiH8Kvdg',
#                secret: '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',
#                password: '',
#                secondary: '',
#                endpoint: '',
#                partner_id: '',
#                app_code: ''
#              },
#              {
#                app_id: App.find_by(tag: 't2g').id,
#                name: 'Stripe',
#                key: 'pk_live_aPBY93f4SI2otr5XM2bnv7J0',
#                secret: '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',
#                password: '',
#                secondary: '',
#                endpoint: '',
#                partner_id: '',
#                app_code: ''
#              }
#            ])
#
# if Rails.env.development?
#   AdminUser.destroy_all
#   AdminUser.create!(email: 'admin@example.com', password: 'password',
#                     password_confirmation: 'password')
# end
