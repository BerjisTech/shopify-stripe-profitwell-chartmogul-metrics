# frozen_string_literal: true

# Model
# rubocop:disable Metrics/AbcSize
# rubocop:disable Metrics/MethodLength
class Todo < ApplicationRecord
  def self.deadline(done, deadline)
    if done == 1
      todo_done
    else
      days = (deadline.to_date - DateTime.now.to_date).to_i
      overdue = (DateTime.now.to_date - deadline.to_date).to_i

      if days > 5
        todo_on_track
      elsif days.positive? && days <= 5
        todo_days_remaining(days)
      elsif days.zero?
        todo_due_today
      else
        todo_overdue(overdue)
      end
    end
  end

  def self.todo_done
    {
      icon: '<span class="material-icons text-success">check_circle</span>',
      days_remaining: '<span class="text-success">On track</span>',
      todo_state: 'checked',
      done_update: 0
    }
  end

  def self.todo_on_track
    {
      icon: '<span class="material-icons text-info">radio_button_unchecked</span>',
      days_remaining: '<span class="text-success">On track</span>',
      todo_state: '',
      done_update: 1
    }
  end

  def self.todo_days_remaining(days)
    {
      icon: '<span class="material-icons text-info">radio_button_unchecked</span>',
      days_remaining: "<span class='text-warning'>#{days} days remaining</span>",
      todo_state: '',
      done_update: 1
    }
  end

  def self.todo_due_today
    {
      icon: '<span class="material-icons text-info">radio_button_unchecked</span>',
      days_remaining: '<span class="text-danger">Due today</span>',
      todo_state: '',
      done_update: 1
    }
  end

  def self.todo_overdue(overdue)
    {
      icon: '<span class="material-icons text-danger">error_outline</span>',
      days_remaining: "<span class='text-danger'>#{overdue} days overdue</span>",
      todo_state: '',
      done_update: 1
    }
  end
end

# rubocop:enable Metrics/MethodLength
# rubocop:enable Metrics/AbcSize
