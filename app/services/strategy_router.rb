require 'strategies/user_info_strategy'
require 'strategies/default_strategy'

class StrategyRouter

  def initialize
    @apiai_service = ApiaiService.new
    @user_service = UserService.new
  end

  private
  
  def user_info_strategy
    @@user_info_strategy ||= UserInfoStrategy.new
  end

  def strategies
    @@strategies ||= {
      get_phone_number: user_info_strategy.method(:get_phone_number),
      get_user_info: user_info_strategy.method(:get_user_info),
      get_user_birthday: user_info_strategy.method(:get_user_birthday)
    }
  end

  DIALOG_CHANNEL = "D"
  UNRECOGNIZED_QUERY_MESSAGE = "Мая не панимать((("
  SUCCESS_RESPONSE_CODE = 200

  def respond_on_message?(data)
    result = true
    if data[:subtype] == 'bot_message'
      result = false
    end
    separated_text = data[:text].split(' ')
    not_person = separated_text[0] != "<@#{ENV['BOT_ID']}>"
    separated_text.delete_at(0) unless not_person
    if data[:channel][0] != DIALOG_CHANNEL and not_person
      result = false
    end
    return result, separated_text.join(' ')
  end

  public

  def handle_request(data)
    is_respond, text = respond_on_message?(data)
    if is_respond
      if data[:user]
        @user_service.add_new_user(data[:user])
      end
      response = @apiai_service.client.text_request text
      if response[:status][:code] == SUCCESS_RESPONSE_CODE
        if strategies[response[:result][:action].to_sym]
          strategies[response[:result][:action].to_sym].call(
              response[:parameters]['given-name'.to_sym], response[:fulfillment][:speech])
        else
          DefaultStrategy::default_strategy(response[:result])
        end
      else
        UNRECOGNIZED_QUERY_MESSAGE
      end
    end
  end
end