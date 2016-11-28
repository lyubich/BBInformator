require 'slack-ruby-client'

class UserService

  private

  def create_user(user_info)
    user_profile = {}
    user_info.user.profile.each do |k, v|
      user_profile[k.to_sym] = v unless v.empty?
    end
    User.create(profile: user_profile)
  end

  def create_adapter(user_info, adapter_type, user_id)
    adapter_data_hash = {slack_id: "#{user_info.user.id}", slack_name: "#{user_info.user.name}",
                         is_deleted: "#{user_info.user.deleted}", is_bot: "#{user_info.user.is_bot}",
                         is_admin: "#{user_info.user.is_admin}", is_owner: "#{user_info.user.is_owner}"}

    Adapter.create(adapter_type: adapter_type, user_id: user_id, data: adapter_data_hash)
  end

  def slack_client
    @@slack_client ||= SlackClientService.new
  end


  public

  def add_new_user(user)
    current_user = Adapter.where("data ->> 'slack_id' = '#{user}'").where(adapter_type: "slack")
    if current_user.empty?
      user_info = slack_client.client.web_client.users_info user: user
      ActiveRecord::Base.transaction do
        new_user = create_user(user_info)
        create_adapter(user_info, "slack", new_user.id)
      end
    end
  end
end