
class UserInfoStrategy
  NOT_FOUND_MESSAGE = "Не знаю такого"
  PHONE_IS_NOT_SET = "Не знаю его номера"
  UNKNOWN = "не знаю"

  def get_phone_number(adapter_id, speech)
    user = fetch_user_info(adapter_id)
    return NOT_FOUND_MESSAGE unless user
    return PHONE_IS_NOT_SET if user.profile['phone'].empty?
    "#{speech} - #{user.profile['phone']}"
  end

  def get_user_info(adapter_id, speech)
    user = fetch_user_info(adapter_id)

    return NOT_FOUND_MESSAGE unless user

    message = "#{speech}:\r\n"
    user.profile.each do |k, v|
      field = v.empty? ? UNKNOWN : v
      message << "#{k} - #{field}\r\n"
    end
    message
  end

  def get_user_birthday(adapter_id, speech)
    user = fetch_user_info(adapter_id)
    return NOT_FOUND_MESSAGE unless user
    "#{speech} - #{user.profile['birthday']}"
  end

  private

  def fetch_user_info(adapter_id)
    user_id = Adapter.where("data ->> 'slack_id' = '#{adapter_id}'").pluck(:user_id)
    User.where(id: user_id).first
  end
end