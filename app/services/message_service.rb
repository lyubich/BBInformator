require 'slack-ruby-client'
require 'json'

class MessageService

  def client
    @@client ||= Slack::RealTime::Client.new
  end

  private

  def create_user(user_info)
    user_profile_hash = {first_name: "#{user_info.user.profile.first_name}",
                         last_name: "#{user_info.user.profile.last_name}",
                         email: "#{user_info.user.profile.email}",
                         skype: "#{user_info.user.profile.skype}",
                         phone: "#{user_info.user.profile.phone}"}

    user_db = User.create(profile: user_profile_hash)
  end

  def create_adapter(user_info, adapter_type, user_id)
    adapter_data_hash = {slack_id: "#{user_info.user.id}", slack_name: "#{user_info.user.name}",
                         is_deleted: "#{user_info.user.deleted}", is_bot: "#{user_info.user.is_bot}",
                         is_admin: "#{user_info.user.is_admin}", is_owner: "#{user_info.user.is_owner}"}

    adapter_db = Adapter.create(adapter_type: adapter_type, user_id: user_id, data: adapter_data_hash)
  end


  public

  def echo (user, channel, text, subtype)
    if subtype != 'bot_message'
      current_user = Adapter.where("data ->> 'slack_id' = '#{user}'").where(adapter_type: "slack")
      if (current_user == [])
        user_info = client.web_client.users_info user: user
        new_user = create_user(user_info)
        create_adapter(user_info, "slack", new_user.id)
      end

      client.web_client.chat_postMessage channel: channel, text: text
    end

  end
end