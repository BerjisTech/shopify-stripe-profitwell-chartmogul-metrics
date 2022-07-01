# frozen_string_literal: true

require 'test_helper'

class TaskCommentRepliesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @task_comment_reply = task_comment_replies(:one)
  end

  test 'should get index' do
    get task_comment_replies_url
    assert_response :success
  end

  test 'should get new' do
    get new_task_comment_reply_url
    assert_response :success
  end

  test 'should create task_comment_reply' do
    assert_difference('TaskCommentReply.count') do
      post task_comment_replies_url,
           params: { task_comment_reply: { reply: @task_comment_reply.reply, task_comment_id: @task_comment_reply.task_comment_id,
                                           task_id: @task_comment_reply.task_id, user_id: @task_comment_reply.user_id } }
    end

    assert_redirected_to task_comment_reply_url(TaskCommentReply.last)
  end

  test 'should show task_comment_reply' do
    get task_comment_reply_url(@task_comment_reply)
    assert_response :success
  end

  test 'should get edit' do
    get edit_task_comment_reply_url(@task_comment_reply)
    assert_response :success
  end

  test 'should update task_comment_reply' do
    patch task_comment_reply_url(@task_comment_reply),
          params: { task_comment_reply: { reply: @task_comment_reply.reply, task_comment_id: @task_comment_reply.task_comment_id,
                                          task_id: @task_comment_reply.task_id, user_id: @task_comment_reply.user_id } }
    assert_redirected_to task_comment_reply_url(@task_comment_reply)
  end

  test 'should destroy task_comment_reply' do
    assert_difference('TaskCommentReply.count', -1) do
      delete task_comment_reply_url(@task_comment_reply)
    end

    assert_redirected_to task_comment_replies_url
  end
end
