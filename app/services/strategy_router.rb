class StrategyRouter
  STRATEGIES = {
    get_phone_number: UserInfoStrategy.method(:get_phone_number),
  }

  def initialize
    @apiai_service = ApiaiService.new
  end

  def user_service
    @@user_service ||= UserService.new
  end

  def handle_request(data)
    if data[:subtype] != 'bot_message'
      if data[:user]
        user_service.add_new_user(data[:user])
      end
      response = @apiai_service.client.text_request data[:text]
      if response[:status][:code] == 200
        if STRATEGIES[response[:result][:action].to_sym]
          STRATEGIES[response[:result][:action].to_sym].call(response[:result], data)
        else
          DefaultStrategy::default_strategy(response[:result])
        end
      else
        "Мая не панимать((("
      end
    end
  end
end