require 'slack-ruby-client'

class MessageService

  def client
    @@client ||= Slack::RealTime::Client.new
  end

  def echo (channel, text, subtype)
    if subtype != 'bot_message'
      client.web_client.chat_postMessage channel: channel, text: text
    end
  end
end