# frozen_string_literal: true

# Model
class Qt < ApplicationRecord
  def self.start_update
    app_id = App.find_by(app_name: 'Quetext').id
    ChartMogul.api_key = Api.key(app_id, 'Chartmogul').key || ''
    # ChartMogul.secret_key = Api.key(app_id, 'Chartmogul').secret || ''
    metrics = OpenStruct.new Chartmogul.format_data(app_id)

    DailyMrr.save_mrr(metrics, app_id)
    DailyMrr.save_count(metrics.plans, app_id, metrics)
  end
end
