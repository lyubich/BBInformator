require 'slack-ruby-client'

class MessageService

  def client
    @@client ||= Slack::RealTime::Client.new
  end

  def echo (user, channel, text)
    if user
      client.web_client.chat_postMessage channel: channel, text: text
    end
  end
end