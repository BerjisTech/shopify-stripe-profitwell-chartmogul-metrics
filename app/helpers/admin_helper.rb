# frozen_string_literal: true

# Admin Helper
module AdminHelper
  def rep_count
    Account.reps.count.to_i
  end

  def username(account_id)
    "#{Account.find(account_id).first_name} #{Account.find(account_id).last_name}"
  end

  def userinitials(account_id)
    Account.find(account_id).first_name[0...2].humanize.to_s
  end
end
