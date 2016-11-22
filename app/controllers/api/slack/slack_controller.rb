class Api::Slack::SlackController < ApplicationController
  skip_before_filter :verify_authenticity_token

  def message_service
    @@message_service ||= MessageService.new
  end

  def group_joined_service
    @@group_joined_service ||= GroupJoinedService.new
  end


  def message
    message_service.echo(params[:user], params[:channel], params[:text])
  end

  def group_joined
    group_joined_service.greetings(params[:channel][:id])
  end
end