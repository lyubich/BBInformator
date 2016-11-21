class Api::SlackController < ApplicationController
  skip_before_filter :verify_authenticity_token

  def message_service
    @@message_service ||= MessageService.new
  end

  def message
    message_service.echo(params[:user], params[:channel], params[:text])
  end
end