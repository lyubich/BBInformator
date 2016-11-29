class BirthdayService

  def slack_client
    @@slack_client ||= SlackClientService.new
  end

  def birthday_notify(channels, text)
    slack_client.client.web_client.chat_postMessage channel: channels, text: text
  end
end