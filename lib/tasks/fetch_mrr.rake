# frozen_string_literal: true

namespace :batch do
  desc 'Fetch MRR from SHopify apps'
  task fetch_mrr: :environment do
    DailyMrr.fetch_mrr
  end
end

# rake test:fetch_mrr
# bundle exec whenever --update-crontab
