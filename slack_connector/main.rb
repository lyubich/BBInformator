require 'slack-ruby-client'
require 'httparty'

require './slack_configuration'

HEADERS = {
    'Content-Type' => 'application/json',
    'Accept' => 'application/json'
}

client = Slack::RealTime::Client.new

def post(options = {})
  HTTParty.post(
      ENV['API_URL'],
      body: options.to_json,
      headers: HEADERS)
end

client.on :message do |data|
  post(data.merge(condition: 'message'))
end


client.on :group_joined do |data|
  Slack::Config.logger.info 'GREETING ------------------------------------------------------'
  Slack::Config.logger.info data
  Slack::Config.logger.info data.channel.id
  client.web_client.chat_postMessage channel: data.channel.id, text: 'О, всем привет!'
  Slack::Config.logger.info 'GREETING STOP ------------------------------------------------------'
end

client.start!