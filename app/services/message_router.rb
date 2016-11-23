require './apiai_service'
require './user_info_service'

class MessageRouter
  STRATEGIES = {
    get_phone_number: UserInfoService.method(:get_phone_number)
  }

  def handle_request(data)
    response = ApiaiService::client.text_request data.text
    if response[:status][:code] == 200
      STRATEGIES[response[:result][:action]].call(response[:result], data)
    else
      "Мая не панимать((("
    end
  end
end