
class UserInfoStrategy
  NOT_FOUND_MESSAGE = "Не знаю такого"
  FIELD_IS_NOT_SET = "Нашёл пустое поле("
  UNKNOWN = "не знаю"

  def get_phone_number(adapter_id, speech)
    user = fetch_user_info(adapter_id)
    check_user_data(user, 'phone', speech)
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
    return FIELD_IS_NOT_SET if user.profile['birthday'].empty?
    "#{speech} - #{user.profile['birthday']}"
  end

  def get_skype(adapter_id, speech)
    user = fetch_user_info adapter_id
    check_user_data(user, 'skype', speech)
  end

  def get_email(adapter_id, speech)
    user = fetch_user_info(adapter_id)
    check_user_data(user, 'email', speech)
  end

  private

  def fetch_user_info(adapter_id)
    user_id = Adapter.where("data ->> 'slack_id' = '#{adapter_id}'").pluck(:user_id)
    User.where(id: user_id).first
  end

  def check_user_data(user, field, text)
    return NOT_FOUND_MESSAGE unless user
    return FIELD_IS_NOT_SET if user.profile[field].empty?
    "#{text} - #{user.profile[field]}"
  end
end