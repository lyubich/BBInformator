
class UserInfoStrategy
  def self.get_phone_number(apiai_data, message_data)
    adapter_id = apiai_data[:parameters][:'given-name']
    user_id = Adapter.where("data ->> 'slack_id' = '#{adapter_id}'").pluck(:user_id)
    user = User.where(id: user_id).first
    "#{apiai_data[:fulfillment][:speech]} - #{user.profile["phone"]}"
  end
end