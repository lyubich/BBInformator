class Api::Slack::SlackController < ApplicationController
  skip_before_filter :verify_authenticity_token

  def strategy_router
    @@strategy_router ||= StrategyRouter.new
  end

  def client
    @@client ||= SlackClientService.new
  end

  def group_joined_service
    @@group_joined_service ||= GroupJoinedService.new
  end


  def message
    logger.info params
    text = strategy_router.handle_request(params)
    client.client.web_client.chat_postMessage channel: params[:channel], text: text
  end

  def group_joined
    group_joined_service.greetings(params[:channel][:id])
  end
end