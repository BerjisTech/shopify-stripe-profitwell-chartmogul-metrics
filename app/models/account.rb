# frozen_string_literal: true

# Model
# rubocop:disable Metrics/MethodLength
class Account < ApplicationRecord
  belongs_to :user

  ROLE_LIST = {
    editor: ['Admin', 'COO', 'CEO', 'HR & Records'],
    contest_manager: ['Admin', 'COO', 'CEO', 'HR & Records'],
    marketing: ['Admin', 'COO', 'CEO', 'HR & Records', 'Marketing'],
    data_manager: ['Admin', 'COO', 'CEO', 'HR & Records', 'Marketing', 'Snr Ops', 'Jnr Ops'],
    ops_manager: ['Admin', 'COO', 'CEO', 'HR & Records', 'Snr Ops', 'Jnr Ops'],
    finance: ['Admin'],
    admin: ['Admin', 'COO', 'CEO', 'HR & Records', 'Finance']
  }.freeze
  class << self
    def editor(user_id)
      user_role = Account.find_by(user_id: user_id).role_id
      ROLE_LIST[:editor].include? Role.find_by(id: user_role).name
    end

    def contest_manager(user_id)
      user_role = Account.find_by(user_id: user_id).role_id
      ROLE_LIST[:contest_manager].include? Role.find_by(id: user_role).name
    end

    def admin(user_id)
      user_role = Account.find_by(user_id: user_id).role_id
      ROLE_LIST[:admin].include? Role.find_by(id: user_role).name
    end

    def role(user_id)
      user_role = Account.find_by(user_id: user_id).role_id
      Role.find(user_role).name.downcase
    end

    def request_percent_increase(user_id)
      last_7_days = Review.where(user_id: user_id, level: 1).where(requested_on: (Date.today - 7)..Date.today).count
      previous_7_days = Review.where(user_id: user_id,
                                     level: 1).where(requested_on: (Date.today - 14)..(Date.today - 8)).count
      format_change(last_7_days, previous_7_days)
    end

    def received_percent_increase(user_id)
      last_7_days = Review.where(user_id: user_id, level: 2).where(received_on: (Date.today - 7)..Date.today).count
      previous_7_days = Review.where(user_id: user_id,
                                     level: 2).where(received_on: (Date.today - 14)..(Date.today - 8)).count
      format_change(last_7_days, previous_7_days)
    end

    def chat_percent_increase(user_id)
      last_7_days = Chat.where(user_id: user_id).where(date: (Date.today - 7)..Date.today).count
      previous_7_days = Chat.where(user_id: user_id).where(date: (Date.today - 14)..(Date.today - 8)).count
      format_change(last_7_days, previous_7_days)
    end

    def call_percent_increase(user_id)
      last_7_days = Call.where(user_id: user_id).where(date: (Date.today - 7)..Date.today).count
      previous_7_days = Call.where(user_id: user_id).where(date: (Date.today - 14)..(Date.today - 8)).count
      format_change(last_7_days, previous_7_days)
    end

    def format_change(last_7_days, previous_7_days)
      difference = last_7_days - previous_7_days
      change = if previous_7_days.zero?
                 100
               else
                 ((difference.to_f / previous_7_days) * 100)
               end
      difference = if difference.positive?
                     "#{difference}+"
                   else
                     difference.to_s
                   end

      hash = { difference: difference, change: change }
      OpenStruct.new hash
    end

    def reps
      Account.where(role_id: Role.find_by(name: 'Customer Hero').id).order(created_at: :desc)
    end

    def app_reps(app_id)
      reps = []
      owners = App.owners(app_id)
      owners.map do |owner|
        rep = Account.find_by(user_id: owner.user_id)
        reps << rep if Role.find(rep.role_id).name == 'Customer Hero'
      end
      reps
    end

    def owned_apps(user_id)
      apps = ''
      Owner.where(user_id: user_id).map do |app|
        apps += "#{App.find(app.app_id).tag.upcase}, "
      end
      apps[0...-2]
    end

    def jnr_ops
      Account.where(role_id: Role.find_by(name: 'Jnr Ops').id)
    end

    def full_names(user_id)
      account = Account.find_by(user_id: user_id)
      if account.present?
        "#{account.first_name.humanize} #{account.last_name.humanize}"
      else
        '-- --'.to_s
      end
    end
  end
end

# rubocop:enable Metrics/MethodLength
