# frozen_string_literal: true

class TaskCommentReply < ApplicationRecord
  has_rich_text :reply
end
