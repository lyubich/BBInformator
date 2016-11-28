
class HelpStrategy
  def get_help(adapter_id, speech)
    response = "#{speech}\r\n"
    response << "*Жирным* выделены команды боту, _курсивом_ - изменяемые части текста\r\n"
    response << "• *номер* _@username_ -> получить номер телефона пользователя\r\n"
    response << "• *расскажи про* _@username_ -> получить список всех данных пользователя\r\n"
    response << "\r\nобращайся =)"
  end
end