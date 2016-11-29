require 'slack-ruby-client'

class UserService

  private

  def slack_client
    @@slack_client ||= SlackClientService.new
  end

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

  def fetch_adapter(adapter_id)
    Adapter.where("data ->> 'slack_id' = '#{adapter_id}'").where(adapter_type: "slack")
  end

  def create_user_and_adapter(user_info)
    ActiveRecord::Base.transaction do
      new_user = create_user(user_info)
      create_adapter(user_info, "slack", new_user.id)
    end
  end

  def fetch_slack_user_data(user_id)
    slack_client.client.web_client.users_info(user: user_id)
  end

  public

  def add_new_user(adapter_id)
    current_user = fetch_adapter(adapter_id)
    unless current_user
      user_info = fetch_slack_user_data(adapter_id)
      create_user_and_adapter(user_info)
    end
  end

  def upsert_user(adapter_id, data)
    current_user = User.joins("INNER JOIN adapters ON users.id = adapters.user_id")
                       .where("data ->> 'slack_id' = '#{adapter_id}'")
                       .where("adapter_type = 'slack'")
                       .select(:id, :profile)[0]
    user_info = current_user['profile']
    data.each do |k, v|
      user_info[k] = v unless v.empty?
    end
    user_info.delete('fields')
    if current_user
      user = User.update(current_user['id'], profile: user_info)
    else
      create_user_and_adapter(user_info)
    end
  end
end