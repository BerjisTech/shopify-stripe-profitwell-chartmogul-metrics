# frozen_string_literal: true

# Requests model
class Request < ApplicationRecord
  def self.provided(provided)
    if provided.zero?
      not_provided
    else
      already_provided
    end
  end

  def self.already_provided
    '<span class="material-icons text-success">check_circle</span>'
  end

  def self.not_provided
    '<span class="material-icons text-info">contact_support</span>'
  end
end
