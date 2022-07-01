# frozen_string_literal: true

# BigRocks Model
# rubocop:disable Metrics/MethodLength
class BigRock < ApplicationRecord
  def self.quaters
    { year: Date.today.strftime('%Y'),
      current_quater: current_quater,
      plannable_quater: next_plannable_quater }
  end

  def self.current_quater
    current_month = Date.today.strftime('%m').to_i

    if current_month.positive? && current_month < 4
      1
    elsif current_month > 3 && current_month < 7
      2
    elsif current_month > 6 && current_month < 7
      3
    else
      4
    end
  end

  def self.next_plannable_quater
    year = Date.today.strftime('%Y').to_i
    current_month = Date.today.strftime('%m').to_i

    if current_month > 1 && current_month < 5
      "Q2 #{year}"
    elsif current_month > 4 && current_month < 8
      "Q3 #{year}"
    elsif current_month > 7 && current_month < 11
      "Q4 #{year}"
    else
      "Q1 #{year + 1}"
    end
  end

  def self.rock_groups
    BigRock.all.select(:quater, :year).group(:quater, :year)
           .order(year: :asc, quater: :asc)
  end

  def self.quaterly_rocks(quater, year)
    BigRock.where(quater: quater).where(year: year).order(created_at: :asc)
  end
end

# rubocop:enable Metrics/MethodLength
