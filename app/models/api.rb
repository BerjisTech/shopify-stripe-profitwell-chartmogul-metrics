# frozen_string_literal: true

# Model
class Api < ApplicationRecord
  def self.wise_api(app)
    Api.find_by(app_id: app, name: 'Wise')
  end

  def self.profitwell_api(app)
    Api.find_by(app_id: app, name: 'ProfitWell')
  end

  def self.key(app, name)
    Api.find_by(app_id: app, name: name)
  end
end
