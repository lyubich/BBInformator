require 'slack-ruby-client'

class SlackClientService
  def client
    @@client ||= Slack::RealTime::Client.new
  end
end