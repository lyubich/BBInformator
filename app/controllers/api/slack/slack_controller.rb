class Api::Slack::SlackController < ApplicationController
  skip_before_filter :verify_authenticity_token

  private

  def strategy_router
    @@strategy_router ||= StrategyRouter.new
  end

  def user_service
    @@user_service ||= UserService.new
  end

  def slack_client
    @@slack_client ||= SlackClientService.new
  end

  def group_joined_service
    @@group_joined_service ||= GroupJoinedService.new
  end

  public

  def message
    logger.info params
    text = strategy_router.handle_request(params)
    if text
      slack_client.client.web_client.chat_postMessage channel: params[:channel], text: text
    end
  end

  def group_joined
    group_joined_service.greetings(params[:channel][:id])
  end

  def team_join
    user_service.add_new_user(params[:user])
  end

  def user_change
    user_service.upsert_user(params[:user][:id], params[:user][:profile])
  end
end