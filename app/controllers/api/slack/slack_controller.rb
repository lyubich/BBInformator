class Api::Slack::SlackController < ApplicationController
  skip_before_filter :verify_authenticity_token

  def strategy_router
    @@strategy_router ||= StrategyRouter.new
  end

  def slack_client
    @@slack_client ||= SlackClientService.new
  end

  def group_joined_service
    @@group_joined_service ||= GroupJoinedService.new
  end


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
end