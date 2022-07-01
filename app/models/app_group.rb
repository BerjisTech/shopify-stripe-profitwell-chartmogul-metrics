# frozen_string_literal: true

# Model
# rubocop:disable Metrics/MethodLength
class AppGroup < ApplicationRecord
  has_many :apps

  def self.letters
    'a'.upto('z').to_a
  end

  def self.fund_apps(fund_id)
    App.where(app_group_id: fund_id)
  end

  def self.select_query_for_mrr(fund_apps)
    query = ''
    fund_apps.each_with_index.map do |app, index|
      query += "SUM(CASE WHEN app_id IN ('#{app.id}') THEN amount ELSE 0 END) as #{letters[index]}, "
    end
    query
  end

  def self.fund_mrr(fund_id)
    fund_apps = fund_apps(fund_id)
    select_query = select_query_for_mrr(fund_apps)
    mrr = DailyMrr.where('date >? ', Date.today - 30).order(date: :asc).select("#{select_query} date").group(:date)
    {
      mrr: mrr,
      apps: fund_apps
    }
  end

  def self.fund_app_ids(fund_id)
    app_ids = ''
    fund_apps(fund_id).map do |app|
      app_ids += "'#{app.id}',"
    end
    app_ids[0...-1]
  end

  def self.latest_mrr(fund_id)
    app_ids = fund_app_ids(fund_id)

    @today = DailyMrr.where(date: Date.today)
                     .select("SUM(CASE WHEN app_id IN (#{app_ids}) THEN amount ELSE 0 END) as mrr")[0].mrr.to_f
    @yesterday = DailyMrr.where(date: Date.today - 1)
                         .select("SUM(CASE WHEN app_id IN (#{app_ids}) THEN amount ELSE 0 END) as mrr")[0].mrr.to_f

    if @today.nil? || @today.zero?
      @yesterday
    else
      @today
    end
  end

  def self.latest_trial(app_id)
    app_ids = fund_app_ids(app_id)

    @today = DailyMrr.where(date: Date.today)
                     .select("SUM(CASE WHEN app_id IN (#{app_ids}) THEN trial ELSE 0 END) as mrr")[0].mrr.to_f
    @yesterday = DailyMrr.where(date: Date.today - 1)
                         .select("SUM(CASE WHEN app_id IN (#{app_ids}) THEN trial ELSE 0 END) as mrr")[0].mrr.to_f

    if @today.nil? || @today.zero?
      @yesterday
    else
      @today
    end
  end

  def self.latest_users(app_id)
    app_ids = fund_app_ids(app_id)

    @today = DailyCount.where(date: Date.today)
                       .select("SUM(CASE WHEN app_id IN (#{app_ids}) THEN user_count ELSE 0 END) as mrr")[0].mrr.to_i
    @yesterday = DailyCount.where(date: Date.today - 1)
                           .select("SUM(CASE WHEN app_id IN (#{app_ids}) THEN user_count ELSE 0 END) as mrr")[0]
                           .mrr.to_i

    if @today.nil? || @today.zero?
      @yesterday
    else
      @today
    end
  end

  def self.members(fund_id)
    app_ids = fund_app_ids(fund_id)
    owners = Owner.where(app_id: app_ids)
    members = []
    owners.map do |owner|
      members << Account.find_by(user_id: owner.user_id)
    end
    members
  end

  def self.member?(fund_id, user_id)
    app_ids = fund_app_ids(fund_id)
    Owner.where(user_id: user_id).where(app_id: app_ids).count
  end
end

# rubocop:enable Metrics/MethodLength
