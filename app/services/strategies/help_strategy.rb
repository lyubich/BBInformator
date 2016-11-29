
class HelpStrategy
  def get_help(adapter_id, speech)
    response = "#{speech}\r\n"
    response << "*Жирным* выделены команды боту, _курсивом_ - изменяемые части текста, комманды, разделённые знаком `|` эквивалентны\r\n"
    response << "• *help* -> список команд боту\r\n"
    response << "• *номер* _@username_ -> получить номер телефона пользователя\r\n"
    response << "• *скайп* _@username_ | *skype* _@username_ -> получить skype пользовател\r\n"
    response << "• *день рождения* _@username_ | *др* _@username_ -> получить дату рождения пользователя\r\n"
    response << "• *почта* _@username_ | *email* _@username_ -> получить email пользователя\r\n"
    response << "• *расскажи про* _@username_ -> получить список всех данных пользователя\r\n"
    response << "\r\nобращайся =)"
  end
end