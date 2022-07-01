# frozen_string_literal: true

# Model
# For transferwise, create recepientr, then quote, then transfer
class Affiliate < ApplicationRecord
  def self.request_get(path, body = [], headers = [])
    data = Faraday.get(path, body, headers)

    data.body
  end

  def self.request_post(path, body = [], headers = [])
    Faraday.post(path, body.to_json, headers)
  end

  def self.business_details(app)
    path = "#{Api.wise_api(app).endpoint}/v1/profiles"
    headers = {
      Authorization: "Bearer #{ENV['WISE_TOKEN']}"
    }

    request_get(path, [], headers)
  end

  def self.create_quote(app) # rubocop:disable Metrics/MethodLength
    path = "#{Api.wise_api(app).endpoint}/v2/quotes"
    headers = {
      Authorization: "Bearer #{ENV['WISE_TOKEN']}",
      'Content-Type': 'application/json'
    }
    body = {
      sourceCurrency: 'USD',
      targetCurrency: 'KES',
      sourceAmount: 1,
      targetAmount: nil,
      profile: 16_705_856
    }
    request_post(path, body, headers).body
  end

  def self.create_transfer(app) # rubocop:disable Metrics/MethodLength
    path = "#{Api.wise_api(app).endpoint}/v1/accounts"
    headers = {
      Authorization: "Bearer #{ENV['WISE_TOKEN']}",
      'Content-Type': 'application/json'
    }
    body = {
      targetAccount: '<recipient account id>',
      quoteUuid: '<quote uuid>',
      customerTransactionId: '<the unique identifier you generated for the transfer attempt>',
      details: {
        reference: 'to my friend',
        transferPurpose: 'verification.transfers.purpose.pay.bills',
        sourceOfFunds: 'verification.source.of.funds.other'
      }
    }
    request_post(path, body, headers).body
  end

  def self.create_affiliate_account(app) # rubocop:disable Metrics/MethodLength
    path = "#{Api.wise_api(app).endpoint}/v1/accounts"
    headers = {
      Authorization: "Bearer #{ENV['WISE_TOKEN']}",
      'Content-Type': 'application/json'
    }
    body = {
      currency: 'GBP',
      type: 'sort_code',
      profile: 16_705_85,
      ownedByCustomer: false,
      accountHolderName: 'Ann Johnson',
      details: {
        legalType: 'PRIVATE',
        sortCode: 'USD',
        accountNumber: 'USD'
      }
    }
    request_post(path, body, headers).body
  end

  def self.pay_through_veem(payment, user) # rubocop:disable Metrics/MethodLength
    path = 'https://sandbox-api.veem.com/veem/v1.1/payments'
    headers = {
      Authorization: 'Bearer <access_token>',
      'X-Request-Id': '<Unique identifier for the request>'
    }
    body = {
      notes: 'Delivery Bill',
      payee: {
        type: 'Business',
        firstName: user.first_name,
        lastName: user.last_name,
        businessName: 'ABC Co',
        countryCode: user.country_code,
        email: user.email,
        phone: user.phone
      },
      payeeAmount: {
        currency: payment.currency,
        number: payment.amount
      },
      purposeOfPayment: 'Goods'
    }
    request_post(path, body, headers).body
  end
end
