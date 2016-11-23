
class UserInfoService
  def self.get_phone_number(apiai_data,message_data)
    username = apiai_data[:parameters][:'given-name']
    adapter = Adapter.where("data ->> 'slack_name' = #{username}")
    number = User.find(id: adapter.user_id, select: "phone_number")
    "#{apiai_data[:resolvedQuery]} - #{number}"
  end
end