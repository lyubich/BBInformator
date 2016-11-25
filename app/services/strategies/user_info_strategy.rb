
class UserInfoStrategy
  NOT_FOUND_MESSAGE = "Не знаю такого"

  def get_phone_number(apiai_data, message_data)
    user = fetch_user_info(apiai_data[:parameters]['given-name'.to_sym])

    return  NOT_FOUND_MESSAGE unless user

    "#{apiai_data[:fulfillment][:speech]} - #{user.profile["phone"]}"
  end

  def get_user_info(apiai_data, message_data)
    user = fetch_user_info(apiai_data[:parameters]['given-name'.to_sym])

    return NOT_FOUND_MESSAGE unless user

    message = "#{apiai_data[:fulfillment][:speech]}:\r\n"
    user.profile.each do |k, v|
      message << "#{k} - #{v}\r\n"
    end
    message
  end

  def fetch_user_info(adapter_id)
    user_id = Adapter.where("data ->> 'slack_id' = '#{adapter_id}'").pluck(:user_id)
    User.where(id: user_id).first
  end
end