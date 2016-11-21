# Slack client configuration

Slack.configure do |config|
  config.token = ENV['SLACK_API_TOKEN']
  config.logger = ::Logger.new(STDOUT)
end