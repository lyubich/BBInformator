require 'api-ai-ruby'

class ApiaiService
  def client
    @@client ||= ApiAiRuby::Client.new(
        client_access_token: ENV['APIAI_TOKEN'],
        api_lang: 'RU'
    )
  end
end