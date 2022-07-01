# frozen_string_literal: true

class Enable < ActiveRecord::Migration[6.1]
  def change
    enable_extension 'pgcrypto'
  end
end
