require 'slack-ruby-client'

class GroupJoinedService

  def client
    @@client ||= Slack::RealTime::Client.new
  end

  def greetings (channel_id)
    client.web_client.chat_postMessage channel: channel_id, text: 'О, всем привет!'
  end
end