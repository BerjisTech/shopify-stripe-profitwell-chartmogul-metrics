# frozen_string_literal: true

json.array! @group_members, partial: 'group_members/group_member', as: :group_member
