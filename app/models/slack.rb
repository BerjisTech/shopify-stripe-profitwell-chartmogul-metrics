# frozen_string_literal: true

class Slack < ApplicationRecord
  class << self
    def token(bot)
      refresh_token = if bot == 'user'
                        'xoxe-1-My0xLTEyMDIyMDY0MDEyODYtMzAxNTczNTc3OTgwOS0zMDExNDEzNjU5NjA0LTQ5MGViMDIyODdkZmFmNjEzOTk1OTc0ZjU2ZDZiZjE0NDNmZGEzMzBhZTNmMDY3ZTVlMDU5ZTRiMjRlMmNmYjU'
                      else
                        'xoxe-1-My0xLTEyMDIyMDY0MDEyODYtMzAwMDE4MTc2NTg2MS0zMDIxNjYwMTEwNzY5LTZjNDY2OTllZGQyNTI4NTgwMmFmMzUzMmEzYTgyODMwMjc2ZGZlNDFjN2IwOTAxZmNiYjNlNzE1NDBmODQzZjI'
                      end
      headers = { 'Content-Type': 'application/x-www-form-urlencoded' }
      body = {
        client_id: SlackApi.first.client_id,
        client_secret: SlackApi.first.client_secret,
        grant_type: 'refresh_token',
        refresh_token: refresh_token
      }
      path = 'https://slack.com/api/oauth.v2.access'
      tokens = JSON.parse(Faraday.post(path, body, headers).body)

      token = OpenStruct.new tokens
      token.access_token
    end

    # SlackApi.first.update(client_id: '1202206401286.3016350192998')
    # SlackApi.first.update(client_secret: 'efb84f8d8d656f51419153c5fd67e92c')
    # SlackApi.first.update(signing_secret: '5444a5c2d6c16d70107efdb23d2da996')
    # SlackApi.first.update(verification_token: 'jcS1EfizOXSCIcVl0Li1M2xn')
    # SlackApi.first.update(current_bot_token: 'xoxb-1202206401286-3008655259927-VySmNmsSaQL0XzlcyTu3qPoy')

    def send_message(body, headers)
      Faraday.post('https://slack.com/api/chat.postMessage', body.to_json, headers)
    end

    def mrr
      mrr_data = "Gross Data as of *#{Date.today.strftime("#{Date.today.day.ordinalize} %b, %Y")}*\n\n"
      App.all.map do |app|
        mrr = DailyMrr.where(app_id: app.id).order(created_at: :desc).first
        mrr_data += "*<http://ltvsaasgrowth.com/apps/#{app.id}|#{app.app_name.humanize}>*\n"
        mrr_data += "_#{mrr.created_at.strftime("#{mrr.created_at.day.ordinalize} %b, %Y")}_\n"
        mrr_data += "Gross Paying MRR *$#{number_with_precision(mrr.amount, precision: 2, delimiter: ',')}*\n"
        mrr_data += "Trial Gross MRR $#{number_with_precision(mrr.trial, precision: 2, delimiter: ',')}\n\n"
      end
      mrr_data
    end

    def contest
      y = Date.today.strftime('%Y').to_i
      m = Date.today.strftime('%m').to_i
      d = Date.today.strftime('%d').to_i
      weeks = Date.today.week_split
      this_month = Date.today.strftime('%B')
      date_start = Date.new(y, m, weeks.first.compact.first)
      date_end = Date.new(y, m, weeks.last.compact.last)

      contest = "*Contest data from #{this_month} so far*\n\n\n"

      Account.reps.map do |rep|
        contest += "*#{rep.first_name} #{rep.last_name}*\n"
        contest += "*#{Review.where(user_id: rep.user_id, level: 1,
                                    requested_on: date_start..date_end).count}* _reviews requested_\n"
        contest += "*#{Review.where(user_id: rep.user_id, level: 2,
                                    received_on: date_start..date_end).count}* _reviews received_\n"
        contest += "*#{Call.where(user_id: rep.user_id, date: date_start..date_end).count}* _live chats_\n"
        contest += "*#{Chat.where(user_id: rep.user_id, date: date_start..date_end).count}* _live calls_\n\n"
      end
      contest
    end

    def slash_event_test(params)
      p = ''
      params.each do |param|
        p += "*#{param}_\n"
      end
      p.gsub('[', '').gsub(']', '').gsub('"', '').gsub(',', '*: _')
    end
  end
end
