class MessagesController < ApplicationController
  before_action :authorized, only: [:create]

  # @route     POST /messages
  # @desc      Create new channel
  # @access    User
  # @params    channel_id, message
  def create
    if message_params[:message].blank? || message_params[:channel_id].blank?
      return render json: { error: 'missing data' }, status: :bad_request
    end

    message = Message.new(user_id: @user.id, message: message_params[:message], channel_id: message_params[:channel_id])
    channel = Channel.find(message_params[:channel_id])
    if message.save
      ChannelChannel.broadcast_to(channel, {
        channel: ChannelSerializer.new(channel),
        users: UserSerializer.new(channel.users),
        messages: MessageSerializer.new(channel.messages)
      })
      render json: MessageSerializer.new(message)
    else
      render json: message.errors, status: :unprocessible_entity
    end
  end

  private

  def message_params
    params.permit(:message, :channel_id)
  end

end
