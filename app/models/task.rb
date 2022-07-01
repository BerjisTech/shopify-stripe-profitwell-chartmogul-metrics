# frozen_string_literal: true

# rubocop:disable Metrics/AbcSize
# rubocop:disable Metrics/MethodLength
# rubocop:disable Metrics/ClassLength
# Model
class Task < ApplicationRecord
  has_rich_text :description

  def self.deadline(done, deadline)
    if done == 1
      task_done
    else
      days = (deadline.to_date - DateTime.now.to_date).to_i
      overdue = (DateTime.now.to_date - deadline.to_date).to_i

      if days > 5
        task_on_track
      elsif days.positive? && days <= 5
        task_days_remaining(days)
      elsif days.zero?
        task_due_today
      else
        task_overdue(overdue)
      end
    end
  end

  def self.task_done
    {
      icon: '<span class="material-icons text-success">check_circle</span>',
      days_remaining: '<span class="days_remaining text-success">Done</span>',
      task_state: 'checked',
      done_update: 0
    }
  end

  def self.task_on_track
    {
      icon: '<span class="material-icons text-info">radio_button_unchecked</span>',
      days_remaining: '<span class="days_remaining text-success">On track</span>',
      task_state: '',
      done_update: 1
    }
  end

  def self.task_days_remaining(days)
    {
      icon: '<span class="material-icons text-info">radio_button_unchecked</span>',
      days_remaining: "<span class='days_remaining text-warning'>#{days} days remaining</span>",
      task_state: '',
      done_update: 1
    }
  end

  def self.task_due_today
    {
      icon: '<span class="material-icons text-info">radio_button_unchecked</span>',
      days_remaining: '<span class="days_remaining text-danger">Due today</span>',
      task_state: '',
      done_update: 1
    }
  end

  def self.task_overdue(overdue)
    {
      icon: '<span class="material-icons text-danger">error_outline</span>',
      days_remaining: "<span class='days_remaining text-danger'>#{overdue} days overdue</span>",
      task_state: '',
      done_update: 1
    }
  end

  def self.start(task, owner)
    stage = TaskStage.find_by(stage: 'Ongoing').id
    fields = if Task.find(task).assigned_to.nil?
               { stage: stage, assigned_to: owner }
             else
               { stage: stage }
             end

    update_stage_and_state(task, fields, stage, 'Task started', owner)
  end

  def self.pause(task, owner)
    stage_to_load = Task.find(task).stage
    update_stage_and_state(task, {
                             state: 2 # 0 => open, 1 => closed, 2 => paused, 3 => rejected
                           }, stage_to_load, 'Task paused', owner)
  end

  def self.resume(task, owner)
    stage_to_load = Task.find(task).stage
    update_stage_and_state(task, {
                             state: 0 # 0 => open, 1 => closed, 2 => paused, 3 => rejected
                           }, stage_to_load, 'Task resumed', owner)
  end

  def self.submit(task, owner)
    stage = TaskStage.find_by(stage: 'Feedback').id
    update_stage_and_state(task, {
                             stage: stage,
                             state: 0
                           }, stage, 'Task submitted for feedback', owner)
  end

  def self.test(task, owner)
    stage = TaskStage.find_by(stage: 'Testing').id
    update_stage_and_state(task, {
                             stage: stage,
                             state: 0
                           }, stage, 'Task submitted for testing', owner)
  end

  def self.review(task, owner)
    stage = TaskStage.find_by(stage: 'Review').id
    update_stage_and_state(task, {
                             stage: stage,
                             state: 0
                           }, stage, 'Task submitted for review', owner)
  end

  def self.document(task, owner)
    stage = TaskStage.find_by(stage: 'Documentation').id
    update_stage_and_state(task, {
                             stage: stage,
                             state: 0
                           }, stage, 'Task submitted for documentation', owner)
  end

  def self.close(task, owner)
    stage = TaskStage.find_by(stage: 'Done').id
    update_stage_and_state(task, {
                             stage: stage,
                             state: 1
                           }, stage, 'Task closed', owner)
  end

  def self.reject(task, owner)
    stage_to_load = Task.find(task).stage
    stage_name = TaskStage.find_by(stage: stage_to_load).stage
    update_stage_and_state(task, { state: 3 }, stage_to_load, "Task #{stage_name} rejected", owner)
  end

  def self.update_stage_and_state(task, fields, stage_to_load, log, owner)
    Task.find(task).update(fields)
    TaskLog.create(task: task, log: log, operator: owner)

    {
      stage_to_load: stage_to_load
    }
  end
end

# rubocop:enable Metrics/ClassLength
# rubocop:enable Metrics/MethodLength
# rubocop:enable Metrics/AbcSize
